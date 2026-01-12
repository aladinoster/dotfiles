return {
	"numToStr/Comment.nvim",
	config = function()
		-- Filetype-specific configurations
		local ft = require("Comment.ft")

		-- wqy to set 1
		ft.yaml = "#%s"

		-- Multiple filetypes sharing settings
		ft({ "go", "rust" }, ft.get("c"))
		ft({ "toml", "graphql" }, "#%s")

		-- Set for your case.
		ft.set("sql", { "--%s", "/*%s*/" })
		ft.set("python", "#%s")
	end,
}
