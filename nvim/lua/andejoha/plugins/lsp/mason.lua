return {
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			-- list of servers for mason to install
			ensure_installed = {
				"lua_ls",
				"ts_ls",
				"omnisharp@v1.39.8",
				"pyright",
				"clangd",
				"terraformls",
			},
		},
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			},
			"neovim/nvim-lspconfig",
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"prettier",
				"autopep8",
				"eslint",
				"pylint",
				"sonarlint-language-server",
				"clang-format",
				"terraform",
			},
		},
		dependencies = {
			"williamboman/mason.nvim",
		},
	},
}
