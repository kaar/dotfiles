#!/usr/bin/env python3
"""Validate the fetched Waybar documentation and generated AGENTS.md block."""

from __future__ import annotations

import argparse
import os
from pathlib import Path
from urllib.parse import quote

START_MARKER = "<!-- waybar-documentation:start -->"
END_MARKER = "<!-- waybar-documentation:end -->"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--project-root",
        type=Path,
        default=Path.cwd(),
        help="Project containing AGENTS.md (default: current directory)",
    )
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    project_root = args.project_root.resolve()
    skill_root = Path(__file__).resolve().parents[1]
    references_root = skill_root / "references"
    upstream_root = references_root / "upstream"
    agents_path = project_root / "AGENTS.md"
    index_path = references_root / "INDEX.md"

    required = (
        upstream_root / "repository/README.md",
        upstream_root / "repository/CONTRIBUTING.md",
        upstream_root / "repository/man/waybar.5.scd.in",
        upstream_root / "repository/man/waybar-styles.5.scd.in",
        upstream_root / "repository/man/waybar-states.5.scd",
        upstream_root / "repository/man/waybar-network.5.scd",
        upstream_root / "repository/man/waybar-custom.5.scd",
        upstream_root / "repository/resources/config.jsonc",
        upstream_root / "repository/resources/style.css",
        upstream_root / "wiki/Configuration.md",
        upstream_root / "wiki/Styling.md",
        upstream_root / "wiki/FAQ.md",
        upstream_root / "wiki/Installation.md",
        upstream_root / "wiki/Writing-Modules.md",
    )
    missing = [str(path) for path in required if not path.is_file()]
    if missing:
        raise SystemExit("Missing required documentation:\n" + "\n".join(missing))

    man_count = sum(1 for path in (upstream_root / "repository/man").glob("*.scd*"))
    wiki_count = sum(1 for path in (upstream_root / "wiki").glob("*.md"))
    if man_count < 50:
        raise SystemExit(f"Expected at least 50 canonical man sources, found {man_count}")
    if wiki_count < 50:
        raise SystemExit(f"Expected at least 50 official wiki pages, found {wiki_count}")

    if not agents_path.is_file() or not index_path.is_file():
        raise SystemExit("AGENTS.md or references/INDEX.md is missing")
    agents = agents_path.read_text(encoding="utf-8")
    index = index_path.read_text(encoding="utf-8")
    if agents.count(START_MARKER) != 1 or agents.count(END_MARKER) != 1:
        raise SystemExit("AGENTS.md must contain exactly one complete generated block")

    skill_relative = Path(os.path.relpath(skill_root, project_root)).as_posix()
    unreferenced: list[str] = []
    for document in sorted(path for path in upstream_root.rglob("*") if path.is_file()):
        relative = document.relative_to(references_root).as_posix()
        local_reference = quote(
            f"{skill_relative}/references/{relative}", safe="/.:_"
        )
        if relative not in index or local_reference not in agents:
            unreferenced.append(relative)
    if unreferenced:
        raise SystemExit(
            "Documentation files missing from INDEX.md or AGENTS.md:\n"
            + "\n".join(unreferenced)
        )

    print(
        f"Validated {man_count} canonical man sources, {wiki_count} wiki pages, "
        f"and {sum(1 for path in upstream_root.rglob('*') if path.is_file())} total files"
    )


if __name__ == "__main__":
    main()
