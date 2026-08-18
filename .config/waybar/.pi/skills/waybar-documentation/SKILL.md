---
name: waybar-documentation
description: Fetches, indexes, and applies the complete official Waybar documentation set, while keeping the project's AGENTS.md documentation references synchronized. Use this skill whenever a user asks about Waybar configuration, JSONC options, CSS styling, modules, custom scripts, IPC, troubleshooting, installation, examples, source development, or refreshing Waybar documentation, even when they do not explicitly ask to consult the docs.
compatibility: Requires Python 3, Git, and network access for documentation refreshes. Local consultation works offline after the first sync.
---

# Waybar Documentation

Use official Waybar sources rather than relying on memory because module options and compositor integrations change between releases.

## Refresh the documentation

From the project root, run:

```bash
python .pi/skills/waybar-documentation/scripts/sync_waybar_docs.py --project-root .
python .pi/skills/waybar-documentation/scripts/validate_waybar_docs.py --project-root .
```

The sync operation:

1. Clones the official [Waybar repository](https://github.com/Alexays/Waybar) and [GitHub wiki](https://github.com/Alexays/Waybar/wiki).
2. Fetches every upstream Markdown document, every canonical scdoc man-page source, wiki synchronization metadata and supplements, default configuration and styling examples, custom-module examples, and protocol references.
3. Records exact upstream commits in `references/SOURCES.md`.
4. Generates the complete local and upstream link inventory in `references/INDEX.md`.
5. Inserts or replaces the marked Waybar documentation block in the project root's `AGENTS.md` without changing user-authored content outside that block.

Use `--main-ref <branch-tag-or-sha>` or `--wiki-ref <branch-tag-or-sha>` when a task requires a specific upstream revision. Without these options, the script fetches each repository's current default branch.

## Select the right references

Read [`references/INDEX.md`](references/INDEX.md) to locate documents. Do not load the entire cache when a targeted set is sufficient.

Use this precedence:

1. Check `waybar --version` and installed `man 5 waybar` or `man 5 waybar-<module>` when exact behavior must match the locally installed release.
2. Use `references/upstream/repository/man/` as the canonical upstream source for bar, module, state, and style options. Waybar explicitly identifies these files as the single source of truth for module documentation.
3. Use `references/upstream/wiki/` for installation, configuration, styling, FAQ, themes, examples, custom-module recipes, and hand-maintained supplements.
4. Use `references/upstream/repository/resources/config.jsonc` and `style.css` as maintained defaults.
5. Use contributor docs, custom-module examples, wiki tooling, and protocol XML only for development tasks that need them.

For common tasks, start with:

- General configuration: `man/waybar.5.scd.in` and `wiki/Configuration.md`
- CSS styling: `man/waybar-styles.5.scd.in` and `wiki/Styling.md`
- States: `man/waybar-states.5.scd` and `wiki/States.md`
- Module configuration: the matching `man/waybar-<module>.5.scd` first, then its `wiki/Module:-*.md` page for supplements
- Custom scripts: `man/waybar-custom.5.scd`, `wiki/Module:-Custom.md`, and the custom examples pages
- Menus: `man/waybar-menu.5.scd` and `wiki/Module:-Custom:-Menu.md`
- Troubleshooting: `wiki/FAQ.md`, then the relevant canonical man source
- Building or contributing: `repository/README.md`, `repository/CONTRIBUTING.md`, and `wiki/Writing-Modules.md`

## Work on Waybar files

Before editing, read each target file in full and inspect the relevant canonical documentation. Preserve JSONC comments and the surrounding style.

After editing:

1. Confirm every configured module and option exists in documentation appropriate to the installed Waybar version.
2. Check JSONC syntax with a parser that supports comments, or launch Waybar with the candidate config in a controlled test.
3. Check CSS against Waybar's GTK CSS selectors and the relevant module state classes.
4. Run `waybar --version` and report version-sensitive differences.
5. Restart or signal Waybar only when the user asks or when the task explicitly includes applying the configuration.
6. Cite the local documentation paths used in the final response.

## Keep AGENTS.md complete

Run the sync script whenever upstream references are missing, stale, or the user asks to refresh documentation. The generated block is bounded by:

```text
<!-- waybar-documentation:start -->
<!-- waybar-documentation:end -->
```

Do not manually edit content inside this block. Regenerate it. Preserve all content outside the markers. Run the validator after every refresh so every fetched document remains referenced by both `references/INDEX.md` and `AGENTS.md`.

## Official-source boundary

Waybar states that it has no official website. Treat `github.com/Alexays/Waybar`, its GitHub wiki, and the repository's generated release pages as official. Distribution man-page mirrors can help with installed-version matching, but do not replace the canonical upstream sources in this cache.
