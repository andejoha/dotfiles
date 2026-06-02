return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")

		require("telescope").setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
					},
				},
			},
		})

		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>fs", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
		vim.keymap.set("n", "<C-f>", builtin.git_files, {})
	end,
}
