return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	lazy = false,
	dependencies = {
		{
			"windwp/nvim-ts-autotag",
			config = function()
				require("nvim-ts-autotag").setup()
			end,
		},
	},
	config = function()
		local ensure_installed = {
			"c",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"c_sharp",
			"javascript",
			"typescript",
			"tsx",
			"html",
			"json",
			"css",
			"python",
			"markdown",
			"markdown_inline",
		}

		require("nvim-treesitter").install(ensure_installed)

		local ts_filetypes = {}
		for _, lang in ipairs(ensure_installed) do
			vim.list_extend(ts_filetypes, vim.treesitter.language.get_filetypes(lang))
		end

		vim.api.nvim_create_autocmd("FileType", {
			pattern = ts_filetypes,
			callback = function(args)
				local bufnr = args.buf

				pcall(vim.treesitter.start, bufnr)

				local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
				if lang and lang ~= "markdown" then
					vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end

				if vim.bo[bufnr].filetype == "markdown" then
					vim.bo[bufnr].syntax = "ON"
				end
			end,
		})
	end,
}
