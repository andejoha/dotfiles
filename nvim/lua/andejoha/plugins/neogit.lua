return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
		"nvim-telescope/telescope.nvim", -- optional
	},
	config = function()
		require("neogit").setup()

		vim.keymap.set("n", "<leader>gs", "<cmd>Neogit<CR>", {})
		vim.keymap.set("n", "<leader>gc", "<cmd>Neogit commit<CR>", {})
		vim.keymap.set("n", "<leader>gp", "<cmd>Neogit pull<CR>", {})
		vim.keymap.set("n", "<leader>gP", "<cmd>Neogit push<CR>", {})
		vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", {})
		vim.keymap.set("n", "<leader>gB", "<cmd>Neogit branch<CR>", {})
	end,
}
