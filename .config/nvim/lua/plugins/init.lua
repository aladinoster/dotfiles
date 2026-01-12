return {
	--require("plugins.telescope"),
	--require("plugins.treesitter"),
	--require("plugins.cmp"),
	--require("plugins.lsp"),

	-- TODO notes
	-- # HACK: Great hack on comments
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = true },
		keys = {
			-- The main Telescope picker
			{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "[S]earch [T]odos" },
			{ "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },

			-- Navigation (Jumping between todos)
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next Todo Comment",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous Todo Comment",
			},
		},
	},
	-- Dev icons
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		config = function()
			require("nvim-web-devicons").setup({ default = true })
		end,
	},

	-- Rembember trigger combinations

	{
		"folke/which-key.nvim",
		event = "VeryLazy", -- Load this plugin on a very lazy event (when needed)
		opts = {
			spec = {
				{ "<leader>f", group = "[F]ind / [F]ile / [F]ormat" },
				{ "<leader>g", group = "[G]it" },
				{ "<leader>h", group = "[H]unks / [H]arpoon " },
				{ "<leader>s", group = "[S]earch / [S]end to REPL" },
				{ "<leader>r", group = "[R]EPL Management" },
				{ "<leader>r", group = "[R]EPL Management" },
				{ "<leader>o", group = "Obsidian" },
				{ "s", group = "[S]urround" },
			},
		},
		keys = {
			{
				"<leader>?", -- Key combination to trigger the which-key popup
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)", -- Description for the key mapping
			},
			{
				"v",
				function()
					require("which-key").show()
				end,
				mode = "v", -- This ensures it triggers in Visual Mode
				desc = "Visual Mode Keymaps",
			},
		},
	},

	-- LSP
	-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
	-- used for completion, annotations and signatures of Neovim apis
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },

	-- Game to play on Vim
	{
		"ThePrimeagen/vim-be-good",
		event = "VeryLazy",
	},

	-- Auto pairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	},

	-- Add more plugins here as needed
}
