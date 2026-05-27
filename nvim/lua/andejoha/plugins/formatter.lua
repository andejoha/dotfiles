return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters = {
				-- Remove carriage return characters (CR) from files
				remove_cr = {
					command = "sed",
					args = { "s/\r//g" },
					stdin = false,
				},
			},
			formatters_by_ft = {
				javascript = { "remove_cr", "prettier" },
				typescript = { "remove_cr", "prettier" },
				vue = { "remove_cr", "prettier" },
				css = { "remove_cr", "prettier" },
				html = { "remove_cr", "prettier" },
				json = { "remove_cr", "prettier" },
				yaml = { "remove_cr", "prettier" },
				markdown = { "remove_cr", "prettier" },
				lua = { "remove_cr", "stylua" },
				python = { "remove_cr", "autopep8" },
				terraform = { "remove_cr", "terraform_fmt" },
				["terraform-vars"] = { "remove_cr", "terraform_fmt" },
				["*"] = { "remove_cr" },
			},
			format_on_save = {
				timeout_ms = 1000,
				lsp_format = "fallback",
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				async = true,
				lsp_format = "fallback",
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
