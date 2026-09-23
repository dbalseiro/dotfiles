# Copilot Instructions

## Repository Purpose and Stack

This repository is a personal Neovim configuration written primarily in Lua, with a small retained Vimscript layer for legacy editing and terminal workflows.

- Runtime: Neovim, using its built-in Lua API (`vim.*`).
- Plugin manager: `folke/lazy.nvim`, bootstrapped by `init.lua`.
- Language: Lua, formatted with StyLua.
- Plugin specifications: Lua tables consumed by `require("lazy").setup(...)`.
- Language tooling: native Neovim LSP, `nvim-cmp`, Mason, Conform, and Treesitter.
- Search: `rg --vimgrep` through Telescope and `vim.opt.grepprg`.
- Legacy behavior: Vimscript sourced from `vim-functions/` through `dbalseiro.utils.vim`.

`lazy-lock.json` is the committed plugin lockfile. Do not hand-edit it; let `lazy.nvim` update it when plugin versions change.

## Layout and Ownership

- `init.lua`: startup order, lazy.nvim bootstrap, root plugin-spec composition, and legacy Vimscript loading. Keep it small and declarative.
- `lua/dbalseiro/core/options.lua`: global editor options and global setup that must happen before plugins load. The leader key belongs here.
- `lua/dbalseiro/core/keymaps.lua`: global, plugin-independent mappings and global autocmds.
- `lua/dbalseiro/plugins/*.lua`: one feature-oriented Lazy plugin specification module per file. Keep plugin-specific mappings, autocmds, and setup alongside the plugin that owns them.
- `lua/dbalseiro/utils/*.lua`: small reusable Lua helpers. Export a local `M` table and return it.
- `vim-functions/*.vim`: retained legacy Vimscript. Source a file through `require("dbalseiro.utils.vim").source_vim("name")` without its `.vim` suffix.

When adding a plugin module, return a Lazy-compatible plugin spec (one table or a list of tables), then add its `require(...)` to the `require("lazy").setup` list in `init.lua`. Preserve the explicit loading order there.

## Lua Style

- Use tabs for indentation. Lua configuration files normally use 2-space editor settings, but `format.lua` intentionally sets Lua buffers to 4 spaces for StyLua and the local configuration convention.
- Use double-quoted Lua strings.
- Use `local` by default. Name module tables `M`; use descriptive `snake_case` for locals and functions.
- Write small local helper functions for a cohesive behavior, then return data-driven plugin specs.
- Use `vim.keymap.set`, `vim.api.nvim_create_autocmd`, and `vim.api.nvim_create_augroup` rather than legacy Lua wrappers or Vim commands when a native Lua API exists.
- Give mappings a `desc`. Follow the established which-key labels with mnemonic bracket notation, such as `"[S]earch [F]iles"`.
- Scope plugin mappings with `{ buffer = bufnr }` or `{ buffer = buffer }` when they only apply to an attached buffer.
- Use `vim.bo`, `vim.wo`, and `vim.opt_local` for local state; use `vim.opt` only for global options.
- Use `pcall` for optional plugin extensions or dependencies that may not be installed. Do not silently swallow required setup failures.
- Prefer Neovim APIs and `require(...)` over string-built Ex commands. Use `vim.cmd` only where the direct API does not fit.
- Keep comments brief and explanatory. Existing comments may be conversational; new comments should explain non-obvious decisions, load-order constraints, or compatibility workarounds.

## Lazy.nvim Plugin Patterns

- Put the repository string first: `"owner/plugin.nvim"`.
- Lazy-load when the plugin supports it using `event`, `cmd`, `keys`, `ft`, or `lazy`; keep startup-critical plugins non-lazy.
- Use `opts = { ... }` for declarative setup. Use `config = function()` only when setup needs imperative code, mappings, multiple setup calls, or dynamically computed options.
- Use `init = function()` for configuration that must run before a plugin loads.
- Declare every dependency in `dependencies`; include optional dependencies only when their feature is enabled.
- Prefer local named spec tables for modules with several related plugins, then return them as a list. See the file tree, Git, and fuzzy finder modules.
- Add plugin keymaps inside the owning plugin spec's `keys`, `config`, or `on_attach`; do not scatter them into `core/keymaps.lua`.
- Retain explicit branches only when already needed for plugin compatibility. Do not add versions to `lazy-lock.json` manually.

## Configuration Behavior

- `<Space>` is both `mapleader` and `maplocalleader`; it must be assigned before plugins load.
- Global indentation is two spaces. Lua filetype indentation is intentionally four spaces.
- The configuration assumes a Nerd Font (`vim.g.have_nerd_font = true`) and macOS clipboard integration via `unnamedplus`.
- `ripgrep` is required for configured grep behavior. `make` is optional but enables Telescope FZF native and LuaSnip's JS regexp support.
- `format.lua` configures format-on-save with Conform. Preserve the existing exclusions for language servers without a stable formatting policy.
- Haskell format-on-save is opt-in per project: configure Fourmolu with a `fourmolu.yaml` or `fourmolu.yml` file at the project root. Conform runs `fourmolu` from that root and skips Haskell files outside such a project; do not reintroduce HLS fallback for them.
- LSP server declarations belong in `config_language_servers` in `plugins/lsp.lua`; Mason installs the table keys and a default handler applies shared capabilities.
- Any new Treesitter grammar should be added to the `languages` list in `plugins/format.lua` and should use its actual parser name.
- Keep the Dockerfile filetype/parser alias in `core/options.lua` unless the underlying plugin behavior makes it obsolete.

## Vimscript Conventions

- Keep legacy behavior in `vim-functions/` rather than rewriting unrelated code to Lua.
- Preserve existing Vimscript indentation and idioms in touched `.vim` files.
- New legacy files should be sourced from the relevant Lua feature module, not directly from `init.lua`, except for startup-wide behavior.
- Do not introduce shell-based destructive file operations without quoting and error handling; prefer Neovim Lua APIs for new functionality.

## Validation and Testing

There is no automated test framework in this repository. Validate changes narrowly:

1. Format touched Lua files with `stylua <files>` and verify with `stylua --check <files>` when StyLua is installed.
2. Run a headless startup check: `nvim --headless '+qa'` using this configuration (for example, `NVIM_APPNAME=vim_lua nvim --headless '+qa'` after installation).
3. For plugin changes, start Neovim and run `:Lazy sync` only when dependencies or plugin revisions changed; then verify the plugin command or keymap interactively.
4. For LSP, formatter, Treesitter, or completion changes, test an affected buffer and inspect `:checkhealth`, `:Mason`, `:ConformInfo`, or `:LspInfo` as appropriate.

Avoid adding a test framework for a small configuration-only change. If adding substantial reusable Lua logic, isolate it in a utility module so it can be exercised by a future headless test.

## Change Discipline

- Make the smallest behavior-focused change possible.
- Do not remove legacy Vimscript or alter established mappings unless the task explicitly requires it.
- Do not reformat unrelated files.
- Keep user-facing keymaps consistent with existing leader groups and descriptions.
- Update this file and `README.md` when architecture, setup prerequisites, or validation workflow materially changes.