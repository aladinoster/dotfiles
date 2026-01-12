return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap-python",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup({
				expand_lines = true,
				controls = { enabled = true },
				floating = { border = "rounded" },
				render = {
					max_type_length = 60,
					max_value_lines = 200,
				},
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.6 },
							{ id = "stacks", size = 0.2 },
							-- { id = "watches", size = 0.2 },
						},
						size = 40,
						position = "left",
					},
					{
						elements = {
							{ id = "repl", size = 0.5 },
							{ id = "console", size = 0.5 },
						},
						size = 10,
						position = "bottom",
					},
				},
			})

			-- 1. BREAKPOINT DESIGN
			vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e51400" })
			vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379", bg = "#31353f", bold = true })
			vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#31353f" })

			local signs = {
				DapBreakpoint = { text = "🔴", texthl = "DapBreakpoint" },
				DapBreakpointCondition = { text = "🔍", texthl = "DapBreakpoint" },
				DapStopped = { text = "▶️", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "DapStopped" },
				DapBreakpointRejected = { text = "🚫", texthl = "DapBreakpoint" },
				DapLogPoint = { text = "📝", texthl = "DapLogPoint" },
			}

			for name, config in pairs(signs) do
				vim.fn.sign_define(name, config)
			end

			-- 2. PYTHON (uv-aware)
			local function get_python_path()
				local venv = os.getenv("VIRTUAL_ENV")
				if venv then
					return venv .. "/bin/python"
				end
				local cwd = vim.fn.getcwd()
				if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
					return cwd .. "/.venv/bin/python"
				end
				return "python3"
			end

			require("dap-python").setup(get_python_path())

			-- 3. CUDA & C++ ADAPTER
			dap.adapters["cuda-gdb"] = {
				type = "executable",
				command = "cuda-gdb",
				args = { "--interpreter=dap" },
			}

			dap.configurations.cuda = {
				{
					name = "CUDA C++: Launch Active File",
					type = "cuda-gdb",
					request = "launch",
					program = function()
						local file = vim.fn.expand("%:p:r")
						-- Force build every time to ensure we are debugging the latest code
						print("Compiling " .. vim.fn.expand("%:t") .. "...")
						local build_cmd = string.format("nvcc -g -G %s -o %s", vim.fn.expand("%:p"), file)
						local result = vim.fn.system(build_cmd)

						if vim.v.shell_error ~= 0 then
							print("Build failed: " .. result)
							return nil
						end
						return file
					end,
					cwd = "${fileDirname}",
					stopOnEntry = false,
				},
			}

			dap.configurations.cpp = dap.configurations.cuda
			dap.configurations.c = dap.configurations.cuda

			-- 4. UI AUTOMATION
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

			-- 5. KEYMAPS
			local set = vim.keymap.set
			set("n", "<leader>dc", dap.continue, { desc = "Debug: Start/Continue" })
			set("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
			set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
			set("n", "<leader>dt", dap.step_out, { desc = "Debug: Step Out" })
			set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
			set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
		end,
	},
}
