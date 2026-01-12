return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { { "nvim-lua/plenary.nvim" } },
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			telescope.setup({
				defaults = {
					prompt_prefix = "> ",
					selection_caret = "> ",
					sorting_strategy = "descending",
					layout_strategy = "flex",
					layout_config = {
						flex = {
							flip_columns = 150,
						},
					},
					mappings = {
						i = {
							["<C-u>"] = false,
							["<C-d>"] = false,
						},
					},
				},
			})

			-- Load the projects extension
			telescope.load_extension("projects")

			-- --- Smart Key Mappings ---

			-- 1. Find Files: Uses project.nvim to find the root, falls back to CWD
			vim.keymap.set("n", "<leader>ff", function()
				local ok, project = pcall(require, "project_nvim.project")
				local root = ok and project.get_project_root() or vim.fn.getcwd()
				builtin.find_files({ cwd = root })
			end, { desc = "[F]ind [F]iles (Project Root)" })

			-- 2. Live Grep: Searches text across the entire project root
			vim.keymap.set("n", "<leader>fg", function()
				local ok, project = pcall(require, "project_nvim.project")
				local root = ok and project.get_project_root() or vim.fn.getcwd()
				builtin.live_grep({ cwd = root })
			end, { desc = "[F]ind by [G]rep (Project Root)" })

			-- 3. Projects: Switch between recent projects
			vim.keymap.set("n", "<leader>fp", function()
				telescope.extensions.projects.projects({})
			end, { desc = "[F]ind [P]rojects" })

			-- 4. Help Tags
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
		end,
	},
}
