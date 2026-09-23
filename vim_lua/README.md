# dbalseiro Neovim Configuration

A personal Lua-first Neovim configuration managed with `lazy.nvim`. It combines LSP-driven editing, completion, formatting, Telescope search, Git tooling, and a small set of retained Vimscript workflows.

## Requirements

- Neovim with Lua and `vim.uv` support
- Git, for the first-run `lazy.nvim` bootstrap
- `ripgrep` (`rg`), used by the configured grep provider and Telescope
- A Nerd Font for configured icons
- `make` to build optional Telescope FZF native support and LuaSnip JS regexp support
- Optional language tools: `stylua`, `black`, `fourmolu`, and the language servers configured through Mason

On macOS, the core dependencies are available with Homebrew:

```sh
brew install neovim git ripgrep make stylua black fourmolu
```

## Installation

Clone this repository into Neovim's configuration directory, then set `MYVIMRC` to the installed `init.lua`. The variable is used to locate the legacy scripts in `vim-functions/`.

```sh
git clone <repository-url> "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
export MYVIMRC="${XDG_CONFIG_HOME:-$HOME/.config}/nvim/init.lua"
nvim
```

Add the `MYVIMRC` export to your shell profile. On first launch, `init.lua` clones `lazy.nvim` automatically and Lazy installs the declared plugins.

To keep this configuration separate from an existing Neovim setup, install it as `$HOME/.config/vim_lua`, set `NVIM_APPNAME=vim_lua`, and set `MYVIMRC` to `$HOME/.config/vim_lua/init.lua` before starting Neovim.

## Structure

```text
init.lua                         Bootstrap lazy.nvim and compose modules
lua/dbalseiro/core/options.lua   Global editor settings and early setup
lua/dbalseiro/core/keymaps.lua   Global mappings and autocmds
lua/dbalseiro/plugins/           Feature-specific lazy.nvim plugin specs
lua/dbalseiro/utils/             Reusable Lua helpers
vim-functions/                   Retained Vimscript features
lazy-lock.json                   Pinned plugin revisions
```

The global leader and local leader are both `<Space>`. Plugin-specific keymaps live next to their plugin configuration; which-key exposes the leader groups.

## Included Tooling

- LSP: Mason-managed `gopls`, `pyright`, `stylua`, `lua_ls`, `denols`, and `haskell-language-server`
- Completion: `nvim-cmp`, LuaSnip, LSP, path, and LazyDev sources
- Formatting: Conform runs StyLua for Lua and Black for Python. Haskell format-on-save uses Fourmolu only in projects with `fourmolu.yaml` or `fourmolu.yml`.
- Syntax and indentation: Treesitter parsers for the configured languages
- Search and navigation: Telescope, FZF native when `make` is available, which-key, Trouble, Neo-tree, and Oil
- Git: Neogit, Diffview, and Gitsigns
- UI: Catppuccin, noice.nvim, nvim-notify, mini.nvim, and todo-comments
- Terminal: neoterm with legacy terminal helpers
- AI completion: `github/copilot.vim`

## Common Keymaps

| Mapping | Action |
| --- | --- |
| `<leader>sf` | Find files with Telescope |
| `<leader>sg` | Live grep with ripgrep |
| `<leader>sn` | Search this Neovim configuration |
| `<leader>f` | Format the current buffer |
| `gd` / `gr` | LSP definition / references |
| `<leader>rn` | Rename symbol through LSP |
| `<leader>ca` | LSP code action |
| `<leader>gg` | Open Neogit |
| `\\` | Reveal the current file in Neo-tree |
| `-` | Open the current directory in Oil |
| `<leader>xx` | Toggle diagnostics in Trouble |
| `,,` | Switch to the last edited buffer |

Run `:WhichKey` or pause after pressing `<Space>` to browse the rest of the configured leader mappings.

## Plugin and Tool Management

Use Lazy's commands from Neovim to inspect or update plugins:

```vim
:Lazy
:Lazy sync
:Lazy check
```

Use Mason to inspect language-server installations:

```vim
:Mason
:LspInfo
:ConformInfo
:checkhealth
```

`lazy-lock.json` records plugin revisions. It changes when Lazy updates plugin versions and should be committed with that intentional update.

## Development and Validation

There is no automated test suite. For Lua configuration changes, format and check touched files when StyLua is installed:

```sh
stylua lua/dbalseiro/path/to/file.lua
stylua --check lua/dbalseiro/path/to/file.lua
```

After installation, verify that the configuration starts without errors:

```sh
MYVIMRC="$HOME/.config/nvim/init.lua" nvim --headless '+qa'
```

For changes to a plugin, LSP, formatter, or Treesitter parser, open a representative file and test the relevant command or keymap interactively.

### Haskell Formatting

Install `fourmolu` and add a `fourmolu.yaml` or `fourmolu.yml` file to a Haskell project's root. Saving any Haskell buffer below that directory runs Fourmolu from that root. Haskell files outside a configured project are not autoformatted.

## Legacy Vimscript

The `vim-functions/` directory remains intentional. It supplies custom backspace behavior, file creation and rename helpers, trailing-whitespace trimming, session cursor restoration, and terminal/Haskell shortcuts. Lua loads these scripts through `dbalseiro.utils.vim`; keep `MYVIMRC` pointed at this configuration's `init.lua` so the loader can find them.