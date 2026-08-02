# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal dotfiles repo (`~/.dotfiles`), symlinked into `$HOME` by `install.sh`. There is no build, lint, or test suite — changes are validated by sourcing the shell config or restarting the affected app.

## Install mechanism

`install.sh` (a bash port of the older `install.py`, kept only for reference) symlinks files from this repo into `$HOME`, skipping the `excludes` list (`readme.md`, `install.py`, `install.sh`, `.git*`, `sublime`, `zsh`, `vscode`, `Brewfile`) and treating `containers` (currently `.config`) specially — for those, it symlinks the *contents* of the directory individually into the matching `$HOME` subdirectory rather than symlinking the directory itself. It refuses to overwrite an existing file/dir at the destination (prints "exists. skipping" and moves on), so re-running is safe. Unlike `install.py`, it is safe to re-run unconditionally — the Python version crashes on a second run because of an unconditional `os.makedirs` in the Sublime install step.

`zsh` and `vscode` are excluded from the generic loop and handled by dedicated functions in `install.py` (`install_sublime`, `install_vscode`) that symlink into app-specific support directories under `~/Library/Application Support/...`. `zsh` itself isn't symlinked as a directory — its files are sourced from within `~/.zshrc`/`~/.zshenv` at their repo path (see below), so no per-file symlinking is needed for it.

When adding a new top-level config file/dir intended for direct `$HOME` symlinking, no extra wiring is needed — `install.py`'s exclude list only needs updating if the new item should be handled specially (like `zsh`) instead of symlinked as-is.

## Shell config load order

1. `.zshenv` — always sourced first (login and non-login shells). Holds `$PATH` construction, `$GOPATH`, `$EDITOR`, tool activations (`mise`), and sources `~/.local.sh` last if present for machine-specific secrets/overrides (gitignored, never committed).
2. `.zprofile` — sourced for login shells only.
3. `.zshrc` — interactive shell setup. Sources `zsh/init.zsh` (guarded by an `-s` file-exists check, so this repo can be absent without breaking the shell), then defines project-agnostic aliases/functions (git shortcuts, `remote_*` ECS exec helpers, `gw-add`/`gw-rm` git-worktree helpers, `gsw` fzf branch switcher).
4. `zsh/init.zsh` — sets zsh options (`AUTO_CD`, `EXTENDED_GLOB`, etc.) and sources the rest of `zsh/*.zsh` in a fixed order: `vim.zsh`, `completions.zsh`, `history.zsh`, `colors.zsh`, `prompts.zsh`, `fasd.zsh`.

Git submodules (`zsh/zsh-completions`, `zsh/prompts/pure`, `zsh/fzf-tab`) are vendored dependencies — don't hand-edit their contents; update via `git submodule update --remote` if a bump is ever needed. Clone with `--recurse-submodules` (see `readme.md`) or these directories will be empty.

## Editing conventions

- Machine-specific or secret values (API keys, per-machine paths) belong in `~/.local.sh`, never in `.zshenv`/`.zshrc` directly — that file is gitignored and sourced last.
- `zsh/*.zsh` files are sourced in the fixed order listed above; a new file must be added to the `source` list in `zsh/init.zsh` explicitly — it is not picked up automatically.
- `.config/<tool>/` directories map directly to `~/.config/<tool>/` via per-file symlinks (not a directory symlink) because `.config` is listed in `install.py`'s `containers`.
- `agent/` holds Claude Code assets for this repo: `agent/skills/` for skills loadable via `/agent-skills:<skill-name>`, and `agent/commands/` for slash commands (typically ones that produce artifacts for later steps).
