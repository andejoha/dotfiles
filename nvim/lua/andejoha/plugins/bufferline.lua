return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	config = function()
		vim.opt.termguicolors = true
		require("bufferline").setup({
			options = {
				mode = "tabs",
				diagnostics = "nvim_lsp",
			},
		})
	end,
}
