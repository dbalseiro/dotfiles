return {
	{ "letorbi/vim-colors-modern-borland" },
	{
		"catppuccin/nvim",

		priority = 1000, -- Make sure to load this before all the other start plugins.

		name = "catppuccin",

		dependencies = {
			"rcarriga/nvim-notify",
		},

		init = function()
			vim.cmd.hi("Comment gui=none")
			require("catppuccin").setup({
				styles = {
					keywords = { "bold" },
					operators = { "bold" },
				},
				transparent_background = true,
			})
			vim.cmd.colorscheme("catppuccin")
			-- vim.cmd.colorscheme 'borland'

			if vim.cmd.color() ~= "catppuccin" then
				local fhandle = io.popen("sw info")
				local result = ""
				if fhandle ~= nil then
					result = fhandle:read("*a")
					fhandle:close()
				end
				vim.opt.background = result == "BreezeDark" and "dark" or "light"
				if result ~= "BreezeDark" then
					vim.cmd([[
            highlight TelescopeNormal         guibg=#eff1f5 guifg=#4c4f69
            highlight TelescopeBorder         guibg=#eff1f5 guifg=#ccd0da
            highlight TelescopePromptNormal   guibg=#e6e9ef guifg=#4c4f69
            highlight TelescopePromptBorder   guibg=#e6e9ef guifg=#ccd0da
            highlight TelescopeResultsNormal  guibg=#eff1f5 guifg=#4c4f69
            highlight TelescopeResultsBorder  guibg=#eff1f5 guifg=#ccd0da
            highlight TelescopePreviewNormal  guibg=#f5f7fa guifg=#4c4f69
            highlight TelescopePreviewBorder  guibg=#f5f7fa guifg=#ccd0da
            highlight TelescopeSelection      guibg=#e6e9ef
            highlight TelescopeMatching       guifg=#7287fd gui=bold
          ]])

					-- Set borders for floating windowslocal orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
					vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#eff1f5 guifg=#4c4f69]])
					vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guibg=#eff1f5 guifg=#ccd0da]])
				end
			end
			-- Set the transparency of floating windows
			vim.o.winblend = 10

			require("notify").setup({
				background_colour = "#000000",
				merge_duplicates = true,
			})
		end,
	},
	{ -- Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			keywords = {
				WIP = { icon = " ", color = "warning" },
			},
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},

	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()
			vim.keymap.set("n", "sA", "Vsa")
			require("mini.icons").setup()
			require("mini.tabline").setup()

			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			local statusline = require("mini.statusline")
			-- set use_icons to true if you have a Nerd Font
			statusline.setup({ use_icons = vim.g.have_nerd_font })

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end

			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim
		end,
	},
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs", -- Sets main module to use for opts
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
				"haskell",
				"python",
				"typescript",
			},
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},
		-- There are additional nvim-treesitter modules that you can use to interact
		-- with nvim-treesitter. You should go explore a few and see what interests you:
		--
		--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
		--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
		--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	},
}
