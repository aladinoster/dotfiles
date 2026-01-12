return {
	"ahmedkhalf/project.nvim",
	config = function()
		require("project_nvim").setup({
			detection_methods = { "lsp", "pattern" }, -- LSP is usually more accurate
			patterns = { ".git", "pyproject.toml", "Makefile", "package.json", "go.mod" },
			manual_mode = false,
		})
		-- Load the telescope extension
		require("telescope").load_extension("projects")
	end,
}
