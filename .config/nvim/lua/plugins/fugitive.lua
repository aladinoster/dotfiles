return {
	-- Fugitive for Git integration
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "Gblame", "Gread", "Gwrite", "Gdiff", "GBrowse" },
		keys = {
			{ "<leader>gs", "<cmd>Git <cr>", desc = "Git status" },
			{ "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
			{ "<leader>gl", "<cmd>Git log<cr>", desc = "Git log" },
			{ "<leader>gd", "<cmd>Git diff<cr>", desc = "Git diff" },
			{ "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
			{ "<leader>gb", "<cmd>GBrowse<cr>", desc = "Open in Remote" },
		},
	},

	-- Gitsigns for inline Git diff signs
	{
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "契" },
				topdelete = { text = "▔" },
				changedelete = { text = "│" },
			},
			current_line_blame = true,
			current_line_blame_opts = {
				delay = 500,
				virt_text_pos = "eol",
			},
			on_attach = function(bufnr)
				local gs = require("gitsigns")

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, "Next Hunk")

				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, "Prev Hunk")

				-- Actions
				map("n", "<leader>hs", gs.stage_hunk, "Stage Hunk")
				map("n", "<leader>hr", gs.reset_hunk, "Reset Hunk")
				map("v", "<leader>hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Stage Selected Hunk")
				map("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Reset Selected Hunk")
				map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
				map("n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")
				map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")
				map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
				map("n", "<leader>hb", function()
					gs.blame_line({ full = true })
				end, "Blame Line")
				map("n", "<leader>hd", gs.diffthis, "Diff This")
				map("n", "<leader>hD", function()
					gs.diffthis("~")
				end, "Diff This ~")
			end,
		}, -- <--- This brace was missing to close the 'opts' and plugin table
	},

	-- Git blame for inline blame information
	{
		"f-person/git-blame.nvim",
		event = "BufRead",
		opts = {},
		keys = {
			{ "<leader>gb", "<cmd>GitBlameToggle<cr>", desc = "Toggle Git Blame" },
		},
	},

	-- Git commit history viewer
	{
		"junegunn/gv.vim",
		dependencies = { "tpope/vim-fugitive" },
		cmd = "GV",
		keys = {
			{ "<leader>gV", "<cmd>GV<cr>", desc = "View Git History" },
		},
	},
}
