return {
	"brianhuster/live-preview.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		-- Define the filetypes you want to trigger live preview for
		local preview_filetypes = {
			markdown = true,
			html = true,
			svg = true,
			asciidoc = true,
		}

		-- Autocommand to start live preview on entering buffer
		vim.api.nvim_create_autocmd("BufEnter", {
			callback = function()
				local ft = vim.bo.filetype
				if preview_filetypes[ft] then
					vim.cmd("LivePreview start")
				end
			end,
		})

		-- Autocommand to stop live preview on leaving buffer
		vim.api.nvim_create_autocmd("BufLeave", {
			callback = function()
				local ft = vim.bo.filetype
				if preview_filetypes[ft] then
					vim.cmd("LivePreview close")
				end
			end,
		})
	end,
}
