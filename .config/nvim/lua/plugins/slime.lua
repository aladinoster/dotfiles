return {
	"jpalardy/vim-slime",
	dev = false,

	init = function()
		-- Target tmux and configure the IPython REPL
		vim.g.slime_target = "tmux" -- Ensure it targets tmux
		vim.g.slime_no_mappings = true -- Disable default mappings provided by vim-slime
		vim.g.slime_python_ipython = 1 -- Use IPython for Python
		vim.g.slime_cell_delimiter = "# %%" -- Define cell delimiter

		-- Pane configuration
		vim.g.slime_default_config = {
			socket_name = vim.split(os.getenv("TMUX") or "", ",")[1],
			target_pane = "{right}",
		}

		-- Add bracketed paste configuration
		vim.g.slime_bracketed_paste = 1 -- Enable bracketed paste mode
	end,

	config = function()
		vim.g.slime_input_pid = false
		vim.g.slime_suggest_default = true
		vim.g.slime_menu_config = false
		vim.g.slime_neovim_ignore_unlisted = true

		vim.g.slime_config_defaults = { python_ipython = 1, dispatch_ipython_pause = 100 }
		vim.g.slime_debug = 1 -- Enable debug mode for troubleshooting
		vim.g.slime_preserve_curpos = 1

		local function _EscapeText_python(text)
			if not text or text == "" then
				return "" -- Return empty if there's no text to process
			end

			local python_ipython = vim.g.slime_config_defaults.python_ipython
			local dispatch_pause = vim.g.slime_config_defaults.dispatch_ipython_pause

			local function split(input, sep)
				sep = sep or "%s"
				local t = {}
				for str in string.gmatch(input, "([^" .. sep .. "]+)") do
					table.insert(t, str)
				end
				return t
			end

			if python_ipython == 1 and #split(text, "\n") > 1 then
				return { "%cpaste -q\n", dispatch_pause, text, "--\n" }
			else
				-- Remove leading/trailing empty lines
				local no_empty_lines = text:gsub("^%s*\n", ""):gsub("\n%s*$", "")
				-- Dedent text by removing leading whitespace
				local dedented_lines = no_empty_lines:gsub("^%s+", "")
				return dedented_lines .. "\n" -- Add newline for execution
			end
		end

		local function _EscapeText_sql(text)
			if not text or text == "" then
				return "" -- Return empty if there's no text to process
			end

			-- Split the text into lines
			local lines = {}
			for line in text:gmatch("[^\r\n]+") do
				table.insert(lines, line)
			end

			-- Trim each line and handle SQL comments by keeping them intact
			for i, line in ipairs(lines) do
				-- Trim leading/trailing spaces and handle comments
				lines[i] = line:gsub("^%s*", ""):gsub("%s*$", "")

				-- Optional: Here, you can add logic to handle multi-line comments or inline comments
				-- For example, handling SQL block comments (/* */) can be added as well if needed.
			end

			-- Rebuild the SQL text, making sure to keep it in the correct format
			local formatted_sql = table.concat(lines, "\n")

			-- Ensure there's a newline at the end for execution
			return formatted_sql .. "\n"
		end

		-- Function to send the current line of code to the tmux pane and execute it
		local function send_current_line_to_right_pane()
			vim.fn["slime#send"](vim.fn.getline(".") .. "\n")
		end

		-- Function to send selected code (from visual mode) to the tmux pane and execute it
		--[[
		local function send_selected_text_to_right_pane()
			local selection = table.concat(vim.fn.getline("'<", "'>"), "\n")
			vim.fn["slime#send"](_EscapeText_python(selection) .. "\n")
		end
        ]]
		--
		local function send_selected_text_to_right_pane()
			local selection = table.concat(vim.fn.getline("'<", "'>"), "\n")

			-- You can add a check for filetype or other conditions to determine whether it's SQL or Python
			local filetype = vim.bo.filetype
			local escaped_text = ""

			if filetype == "python" then
				escaped_text = _EscapeText_python(selection)
			elseif filetype == "sql" then
				escaped_text = _EscapeText_sql(selection)
			else
				-- Default to Python (or some other behavior)
				escaped_text = _EscapeText_python(selection)
			end

			vim.fn["slime#send"](escaped_text .. "\n")
		end

		-- Key mappings to send code to the tmux pane
		vim.keymap.set(
			"n",
			"<leader>t", -- Changed to <leader>t
			send_current_line_to_right_pane,
			{ desc = "Send current line to tmux right pane" }
		)
		vim.keymap.set(
			"v",
			"<leader>t", -- Changed to <leader>t for selected text as well
			send_selected_text_to_right_pane,
			{ desc = "Send selected text to tmux right pane" }
		)
	end,
}
