return {
	"mfussenegger/nvim-dap",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		local dap = require("dap")
		dap.adapters.codelldb = {
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
		}
		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = false,
			},
		}

		require("nvim-dap-virtual-text").setup()

		local dapui = require("dapui")
		dapui.setup()
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		require("mason-nvim-dap").setup({
			automatic_installation = true,
			ensure_installed = {
				"codelldb",
			},
		})

		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
		vim.keymap.set("n", "<F5>", dap.continue, { desc = "Continue" })
		vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step Into" })
		vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step Over" })
		vim.keymap.set("n", "<leader>dx", dap.terminate, { desc = "Terminate" })
	end,
}
