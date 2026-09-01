local M = {}

M.setup = function()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "lua",
		callback = function()
			vim.opt_local.tabstop = 4
			vim.opt_local.shiftwidth = 4
			vim.opt_local.softtabstop = 4
			vim.opt_local.expandtab = true
		end,
	})

	return {
		"godlygeek/tabular",
		"ekalinin/Dockerfile.vim",
		{ -- Highlight, edit, and navigate code
			"nvim-treesitter/nvim-treesitter",
			branch = "main",
			build = ":TSUpdate",
			lazy = false,
			-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
			config = function()
				local ts = require("nvim-treesitter")
				local languages = {
					"bash",
					"c",
					"diff",
					"dockerfile",
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
				}
				ts.setup()
				ts.install(languages)
				vim.api.nvim_create_autocmd("FileType", {
					pattern = languages,
					callback = function()
						vim.treesitter.start()
						vim.bo.indentexpr = "v:lua.vim.treesitter.indentexpr()"
					end,
				})
			end,
		},
		{ -- Autoformat
			"stevearc/conform.nvim",
			event = { "BufWritePre" },
			cmd = { "ConformInfo" },
			keys = {
				{
					"<leader>f",
					function()
						require("conform").format({ async = true, lsp_format = "fallback" })
					end,
					mode = "",
					desc = "[F]ormat buffer",
				},
			},
			opts = {
				notify_on_error = false,
				format_on_save = function(bufnr)
					-- Disable "format_on_save lsp_fallback" for languages that don't
					-- have a well standardized coding style. You can add additional
					-- languages here or re-enable it for the disabled ones.
					local disable_filetypes =
						{ c = true, cpp = true, haskell = true, typescript = true, typescriptreact = true }
					local lsp_format_opt
					if disable_filetypes[vim.bo[bufnr].filetype] then
						lsp_format_opt = "never"
					else
						lsp_format_opt = "fallback"
					end
					return {
						timeout_ms = 500,
						lsp_format = lsp_format_opt,
					}
				end,
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform can also run multiple formatters sequentially
					python = { "black" },
					--
					-- You can use 'stop_after_first' to run the first available formatter from the list
					-- javascript = { "prettierd", "prettier", stop_after_first = true },
				},
			},
		},
	}
end

return M
