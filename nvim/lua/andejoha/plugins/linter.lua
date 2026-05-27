return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			javascript = { "eslint" },
			typescript = { "eslint" },
			python = { "pylint" },
		}

		lint.linters.pylint.cmd = "python"
		lint.linters.pylint.args = {
			"-m",
			"pylint",
			"-f",
			"json",
			"--from-stdin",
			function()
				return vim.api.nvim_buf_get_name(0)
			end,
		}

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("lint", { clear = true }),
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end)
	end,
}
