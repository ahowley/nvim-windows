local function get_vim_color(darken)
	local recording_register = vim.fn.reg_recording()
	-- local colors = require("tokyonight.colors").setup()
	local colors = {
		red = "#cc241d",
		green = "#686d43",
		green2 = "#5a633a",
		magenta = "#8f3f71",
		blue = "#665c54",
	}
	local util = require("tokyonight.util")
	if require("feline.providers.vi_mode").get_vim_mode() == "INSERT" then
		return util.darken(colors.red, darken)
	elseif require("feline.providers.vi_mode").get_vim_mode() == "VISUAL" then
		return util.darken(colors.green, darken)
	elseif require("feline.providers.vi_mode").get_vim_mode() == "LINES" then
		return util.darken(colors.green2, darken)
	elseif recording_register ~= "" then
		return util.darken(colors.magenta, darken)
	else
		return util.darken(colors.blue, darken)
	end
end

return {
	"nanozuki/tabby.nvim",
	event = "VimEnter",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("tabby.tabline").set(function(line)
			local theme = {
				fill = "TabLineFill",
				-- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
				head = "TabLine",
				current_tab = "TabLineSel",
				tab = "TabLine",
				win = "TabLine",
				tail = "TabLine",
			}
			return {
				{
					{ "  ", hl = theme.head },
					line.sep("", theme.head, theme.fill),
				},
				line.tabs().foreach(function(tab)
					local hl = tab.is_current() and theme.current_tab or theme.tab
					return {
						line.sep("", hl, theme.fill),
						tab.is_current() and "" or "󰆣",
						tab.number(),
						tab.name(),
						tab.close_btn(""),
						line.sep("", hl, theme.fill),
						hl = hl,
						margin = " ",
					}
				end),
				line.spacer(),
				line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
					return {
						line.sep("", theme.win, theme.fill),
						win.is_current() and "" or "",
						win.buf_name(),
						line.sep("", theme.win, theme.fill),
						hl = theme.win,
						margin = " ",
					}
				end),
				{
					line.sep("", theme.tail, theme.fill),
					{ "  ", hl = theme.tail },
				},
				hl = theme.fill,
			}
		end)
		-- configs...
	end,
}
