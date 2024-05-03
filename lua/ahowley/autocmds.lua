require("ahowley.remap")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

autocmd("BufWritePre", {
	desc = "Remove whitespace on save",
	pattern = "",
	command = ":%s/\\s\\+$//e",
})

autocmd("ModeChanged", {
	desc = "Redraw on mode change to avoid disappearing statusline",
	callback = function()
		vim.schedule(function()
			vim.cmd("redraw")
		end)
	end,
})

autocmd("WinEnter", {
	desc = "Close all floating windows when changing windows",
	callback = function()
		local current_window = vim.api.nvim_win_get_config(0)
		if current_window.relative ~= "" then
			return
		end
		require("goto-preview").close_all_win()
		-- for _, window_id in ipairs(vim.api.nvim_list_wins()) do
		-- 	if vim.api.nvim_win_get_config(window_id).relative ~= "" then
		-- 		vim.api.nvim_win_close(window_id, false)
		-- 	end
		-- end
	end,
})
