#!/usr/bin/env python3
"""Fetch official Waybar documentation and synchronize its AGENTS.md index."""

from __future__ import annotations

import argparse
import os
import shutil
import subprocess
import tempfile
from pathlib import Path
from urllib.parse import quote

MAIN_REPOSITORY = "https://github.com/Alexays/Waybar.git"
WIKI_REPOSITORY = "https://github.com/Alexays/Waybar.wiki.git"
START_MARKER = "<!-- waybar-documentation:start -->"
END_MARKER = "<!-- waybar-documentation:end -->"


def run(*args: str, cwd: Path | None = None) -> str:
    result = subprocess.run(
        args,
        cwd=cwd,
        check=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
    )
    return result.stdout.strip()


def clone(repository: str, destination: Path, ref: str | None) -> str:
    run("git", "clone", "--depth", "1", repository, str(destination))
    if ref:
        run("git", "fetch", "--depth", "1", "origin", ref, cwd=destination)
        run("git", "checkout", "--detach", "FETCH_HEAD", cwd=destination)
    return run("git", "rev-parse", "HEAD", cwd=destination)


def copy_file(source: Path, destination: Path) -> None:
    destination.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(source, destination)


def copy_tree(source: Path, destination: Path) -> None:
    if source.exists():
        shutil.copytree(
            source,
            destination,
            dirs_exist_ok=True,
            ignore=shutil.ignore_patterns(".git", "__pycache__", "*.pyc"),
        )


def collect_repository_docs(source: Path, destination: Path) -> None:
    for document in source.rglob("*.md"):
        if ".git" not in document.parts:
            copy_file(document, destination / document.relative_to(source))

    for directory in ("man", ".github/wiki", "resources/custom_modules", "protocol"):
        copy_tree(source / directory, destination / directory)

    for filename in ("LICENSE", "resources/config.jsonc", "resources/style.css"):
        path = source / filename
        if path.exists():
            copy_file(path, destination / filename)


def category(relative_path: Path) -> str:
    path = relative_path.as_posix()
    if path.startswith("upstream/repository/man/"):
        return "Canonical man-page sources"
    if path.startswith("upstream/wiki/"):
        return "Official wiki"
    if path.startswith("upstream/repository/resources/"):
        return "Default configuration and module examples"
    if path.startswith("upstream/repository/.github/wiki/"):
        return "Wiki synchronization metadata and hand-maintained extras"
    if path.startswith("upstream/repository/protocol/"):
        return "Protocol references"
    return "Project, contributor, and support documentation"


def upstream_url(relative_path: Path, main_commit: str, wiki_commit: str) -> str:
    parts = relative_path.parts
    if parts[:2] == ("upstream", "wiki"):
        page = relative_path.relative_to("upstream/wiki").with_suffix("").as_posix()
        return f"https://github.com/Alexays/Waybar/wiki/{quote(page, safe='/:')}"

    repository_path = relative_path.relative_to("upstream/repository").as_posix()
    return (
        "https://github.com/Alexays/Waybar/blob/"
        f"{main_commit}/{quote(repository_path, safe='/.:')}"
    )


def inventory_lines(
    references_root: Path,
    project_root: Path,
    skill_root: Path,
    main_commit: str,
    wiki_commit: str,
) -> list[str]:
    documents = sorted(
        path
        for path in (references_root / "upstream").rglob("*")
        if path.is_file()
    )
    skill_relative = Path(os.path.relpath(skill_root, project_root))
    grouped: dict[str, list[str]] = {}

    for document in documents:
        relative = document.relative_to(references_root)
        local_path = skill_relative / "references" / relative
        local_url = quote(local_path.as_posix(), safe="/.:_")
        source_url = upstream_url(relative, main_commit, wiki_commit)
        label = relative.as_posix()
        grouped.setdefault(category(relative), []).append(
            f"- [`{label}`](<{local_url}>) ([upstream](<{source_url}>))"
        )

    lines: list[str] = []
    order = (
        "Canonical man-page sources",
        "Official wiki",
        "Default configuration and module examples",
        "Wiki synchronization metadata and hand-maintained extras",
        "Protocol references",
        "Project, contributor, and support documentation",
    )
    for heading in order:
        entries = grouped.get(heading, [])
        if entries:
            lines.extend((f"### {heading}", "", *entries, ""))
    return lines


def render_sources(main_commit: str, wiki_commit: str) -> str:
    return f"""# Official Waybar Documentation Sources

The Waybar project states that its only official distribution and documentation host is GitHub. Module man pages under `man/` are the single source of truth and are automatically synchronized to generated wiki module pages.

- Main repository: <https://github.com/Alexays/Waybar>
- Main repository commit: `{main_commit}`
- Wiki: <https://github.com/Alexays/Waybar/wiki>
- Wiki Git repository: <https://github.com/Alexays/Waybar.wiki.git>
- Wiki commit: `{wiki_commit}`
- Releases: <https://github.com/Alexays/Waybar/releases>

The local inventory is in [INDEX.md](INDEX.md).
"""


def render_index(
    references_root: Path,
    project_root: Path,
    skill_root: Path,
    main_commit: str,
    wiki_commit: str,
) -> str:
    lines = inventory_lines(
        references_root, project_root, skill_root, main_commit, wiki_commit
    )
    return "\n".join(
        (
            "# Waybar Documentation Index",
            "",
            "This is the complete inventory fetched from Waybar's official main repository and official GitHub wiki. Prefer canonical `man/` sources for module options. Use wiki pages for guides, examples, FAQs, and hand-maintained supplements.",
            "",
            f"- Main repository commit: `{main_commit}`",
            f"- Wiki commit: `{wiki_commit}`",
            "",
            *lines,
        )
    ).rstrip() + "\n"


def render_agents_block(
    references_root: Path,
    project_root: Path,
    skill_root: Path,
    main_commit: str,
    wiki_commit: str,
) -> str:
    skill_relative = Path(os.path.relpath(skill_root, project_root)).as_posix()
    lines = inventory_lines(
        references_root, project_root, skill_root, main_commit, wiki_commit
    )
    return "\n".join(
        (
            START_MARKER,
            "## Waybar Documentation",
            "",
            "Use the official documentation cached by the project-local `waybar-documentation` skill before changing Waybar configuration, styling, modules, scripts, or contributor code.",
            "",
            "- Canonical module documentation is in `references/upstream/repository/man/`. These scdoc files are the upstream source of truth.",
            "- The official wiki adds installation, configuration, styling, FAQ, examples, themes, and hand-maintained module supplements.",
            "- Match behavior to the installed Waybar version when it differs from upstream `master`; check `waybar --version` and installed man pages.",
            f"- Refresh every reference and this generated block with `python {skill_relative}/scripts/sync_waybar_docs.py --project-root .`.",
            f"- Validate coverage with `python {skill_relative}/scripts/validate_waybar_docs.py --project-root .`.",
            f"- Start with [`references/INDEX.md`](<{quote(skill_relative + '/references/INDEX.md', safe='/.:_')}>) and [`references/SOURCES.md`](<{quote(skill_relative + '/references/SOURCES.md', safe='/.:_')}>).",
            "",
            "### Complete fetched documentation inventory",
            "",
            *lines,
            END_MARKER,
        )
    ).rstrip() + "\n"


def update_agents(agents_path: Path, block: str) -> None:
    existing = agents_path.read_text(encoding="utf-8") if agents_path.exists() else ""
    has_start = START_MARKER in existing
    has_end = END_MARKER in existing
    if has_start != has_end:
        raise RuntimeError(
            f"Refusing to update malformed generated block in {agents_path}"
        )

    if has_start:
        prefix, remainder = existing.split(START_MARKER, 1)
        _, suffix = remainder.split(END_MARKER, 1)
        updated = prefix.rstrip() + "\n\n" + block.rstrip() + suffix
    elif existing.strip():
        updated = existing.rstrip() + "\n\n" + block
    else:
        updated = block
    agents_path.write_text(updated.rstrip() + "\n", encoding="utf-8")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--project-root",
        type=Path,
        default=Path.cwd(),
        help="Project containing AGENTS.md (default: current directory)",
    )
    parser.add_argument("--main-ref", help="Optional main repository branch, tag, or SHA")
    parser.add_argument("--wiki-ref", help="Optional wiki branch, tag, or SHA")
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    project_root = args.project_root.resolve()
    skill_root = Path(__file__).resolve().parents[1]
    references_root = skill_root / "references"
    upstream_root = references_root / "upstream"

    with tempfile.TemporaryDirectory(prefix="waybar-documentation-") as temporary:
        temporary_root = Path(temporary)
        main_source = temporary_root / "Waybar"
        wiki_source = temporary_root / "Waybar.wiki"
        main_commit = clone(MAIN_REPOSITORY, main_source, args.main_ref)
        wiki_commit = clone(WIKI_REPOSITORY, wiki_source, args.wiki_ref)

        if upstream_root.exists():
            shutil.rmtree(upstream_root)
        repository_destination = upstream_root / "repository"
        wiki_destination = upstream_root / "wiki"
        collect_repository_docs(main_source, repository_destination)
        copy_tree(wiki_source, wiki_destination)

    references_root.mkdir(parents=True, exist_ok=True)
    (references_root / "SOURCES.md").write_text(
        render_sources(main_commit, wiki_commit), encoding="utf-8"
    )
    (references_root / "INDEX.md").write_text(
        render_index(
            references_root, project_root, skill_root, main_commit, wiki_commit
        ),
        encoding="utf-8",
    )
    update_agents(
        project_root / "AGENTS.md",
        render_agents_block(
            references_root, project_root, skill_root, main_commit, wiki_commit
        ),
    )

    document_count = sum(1 for path in upstream_root.rglob("*") if path.is_file())
    print(f"Fetched {document_count} official Waybar documentation files")
    print(f"Updated {references_root / 'INDEX.md'}")
    print(f"Updated {project_root / 'AGENTS.md'}")


if __name__ == "__main__":
    main()
