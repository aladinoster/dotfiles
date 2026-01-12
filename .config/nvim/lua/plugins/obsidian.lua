local handle = io.popen("hostname")
local hostname = handle:read("*a"):gsub("%s+", "")
handle:close()

local workspaces = {}
if hostname == "PC394058" then
	workspaces = {
		{ name = "perso", path = "/mnt/c/Users/AL772532/OneDrive - RATP/Documents/obsidian" },
		{ name = "work", path = "/mnt/c/Users/AL772532/OneDrive - RATP/Documents/work" },
	}
else
	workspaces = {
		{ name = "personal", path = "~/Documents/Obsidian/obsidian" },
	}
end

return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	keys = {
		{ "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Obsidian Search" },
		{ "<leader>on", "<cmd>ObsidianNew<cr>", desc = "Obsidian New Note" },
		{ "<leader>ot", "<cmd>ObsidianTemplate<cr>", desc = "Obsidian Template" },
		{ "<leader>oe", ":ObsidianExtractNote<cr>", desc = "Obsidian Extract Note", mode = "v" },
		{ "<leader>ov", "<cmd>ObsidianFollowLink vsplit<cr>", desc = "Obsidian Follow (Vsplit)" },
		{ "<leader>of", "<cmd>ObsidianFollowLink <cr>", desc = "Obsidian Follow (Link)" },
		{ "<leader>ch", "<cmd>lua require('obsidian').util.toggle_checkbox()<cr>", desc = "Obsidian Checkbox" },
	},
	-- IMPORTANT: All obsidian-specific settings must go inside 'opts'
	opts = {
		workspaces = workspaces,
		new_notes_location = "📥 Inbox",
		daily_notes = {
			folder = "📅 Daily",
			date_format = "%Y-%m-%d",
			alias_format = "%B %-d, %Y",
			default_tags = { "daily-notes" },
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "markdown",
			callback = function()
				vim.opt_local.conceallevel = 2
			end,
		})
	end,
}
