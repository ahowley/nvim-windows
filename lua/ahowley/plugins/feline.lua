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

local function get_left_sep(darken)
	return {
		{
			str = "slant_left",
			hl = function()
				local vim_color = get_vim_color(darken)
				return {
					fg = vim_color,
					bg = "bg",
				}
			end,
		},
		{
			str = " ",
			hl = function()
				local vim_color = get_vim_color(darken)
				return {
					fg = vim_color,
					bg = vim_color,
				}
			end,
		},
	}
end

local function get_right_sep(darken)
	return {
		{
			str = " ",
			hl = function()
				local vim_color = get_vim_color(darken)
				return {
					fg = vim_color,
					bg = vim_color,
				}
			end,
		},
		{
			str = "slant_left",
			hl = function()
				local vim_color = get_vim_color(darken)
				return {
					fg = "bg",
					bg = vim_color,
				}
			end,
		},
	}
end

return {
	"feline-nvim/feline.nvim",
	config = function()
		-- local colors = require("tokyonight.colors").setup()
		local util = require("tokyonight.util")
		local colors = {
			red = "#cc241d",
			green = "#686d43",
			green2 = "#5a633a",
			magenta = "#8f3f71",
			blue = "#665c54",
		}

		local function vi_mode_component()
			return {
				provider = function()
					local recording_register = vim.fn.reg_recording()
					if recording_register ~= "" then
						return "RECORDING " .. recording_register
					else
						return require("feline.providers.vi_mode").get_vim_mode()
					end
				end,
				hl = function()
					return {
						fg = colors.bg,
						bg = get_vim_color(1.0),
					}
				end,
				left_sep = {
					str = " ",
					hl = function()
						return {
							fg = get_vim_color(1.0),
							bg = get_vim_color(1.0),
						}
					end,
				},
				-- left_sep = get_left_sep(0.2),
				right_sep = get_right_sep(1.0),
			}
		end

		local function git_component()
			return {
				provider = function()
					local has_git_info = require("feline.providers.git").git_info_exists()
					if not has_git_info then
						return ""
					end

					local branch_icon = ""
					local branch = require("feline.providers.git").git_branch()
					local added_icon = " "
					local added = require("feline.providers.git").git_diff_added()
					vim.api.nvim_set_hl(
						0,
						"GitAddedStatusline",
						{ fg = util.lighten(colors.green, 0.8), bg = get_vim_color(0.3) }
					)
					local removed_icon = " "
					local removed = require("feline.providers.git").git_diff_removed()
					vim.api.nvim_set_hl(
						0,
						"GitRemovedStatusline",
						{ fg = util.lighten(colors.red, 0.8), bg = get_vim_color(0.3) }
					)
					local changed_icon = "󰜥 "
					local changed = require("feline.providers.git").git_diff_changed()
					vim.api.nvim_set_hl(
						0,
						"GitChangedStatusline",
						{ fg = util.lighten(colors.blue, 0.8), bg = get_vim_color(0.3) }
					)

					local git_string = branch_icon .. " " .. branch
					if added ~= "" then
						git_string = git_string .. " %#GitAddedStatusline#" .. added_icon .. added
					end
					if removed ~= "" then
						git_string = git_string .. " %#GitRemovedStatusline#" .. removed_icon .. removed
					end
					if changed ~= "" then
						git_string = git_string .. " %#GitChangedStatusline#" .. changed_icon .. changed
					end
					return git_string
				end,
				hl = function()
					return {
						fg = "fg",
						bg = get_vim_color(0.3),
					}
				end,
				left_sep = get_left_sep(0.3),
				right_sep = get_right_sep(0.3),
			}
		end

		local function file_component()
			return {
				provider = "file_info",
				hl = function()
					return {
						fg = get_vim_color(0.8),
						bg = get_vim_color(0.3),
					}
				end,
				left_sep = get_left_sep(0.3),
				right_sep = get_right_sep(0.3),
			}
		end

		local function action_component()
			return {
				provider = require("action-hints").statusline,
				hl = {
					-- fg = util.lighten(colors.bg_visual, 0.5),
					fg = util.lighten("#928374", 0.8),
					-- bg = util.darken(colors.bg_visual, 0.5),
					bg = util.darken("#928374", 0.8),
				},
				left_sep = {
					str = "slant_left",
					hl = {
						fg = util.darken("#928374", 0.8),
						bg = "bg",
					},
				},
				right_sep = {
					{
						str = " ",
						hl = {
							fg = util.darken("#928374", 0.8),
							bg = util.darken("#928374", 0.8),
						},
					},
					{
						str = "slant_left",
						hl = {
							fg = "bg",
							bg = util.darken("#928374", 0.8),
						},
					},
				},
			}
		end

		local function search_component()
			return {
				provider = "search_count",
				hl = function()
					return {
						fg = get_vim_color(0.8),
						bg = get_vim_color(0.3),
					}
				end,
				left_sep = get_left_sep(0.3),
				right_sep = get_right_sep(0.3),
			}
		end

		local function breadcrumbs_component()
			return {
				provider = function()
					if require("nvim-navic").get_data() then
						return require("nvim-navic").get_location()
					else
						return ""
					end
				end,
				short_provider = function()
					return ""
				end,
				hl = function()
					return {
						fg = get_vim_color(1),
						bg = get_vim_color(0.4),
					}
				end,
				left_sep = get_left_sep(0.4),
				right_sep = get_right_sep(0.4),
			}
		end

		local blank_component = function()
			return {
				provider = "",
				hl = {
					fg = colors.bg,
					bg = colors.bg,
				},
				always_visible = true,
			}
		end

		local lsp_component = function(provider_str, base_color)
			return {
				provider = provider_str,
				short_provider = function()
					return ""
				end,
				hl = {
					fg = util.lighten(base_color, 0.8),
					bg = util.darken(base_color, 0.8),
				},
				left_sep = {
					str = "slant_left",
					hl = {
						fg = util.darken(base_color, 0.8),
						bg = "bg",
					},
				},
				right_sep = {
					{
						str = " ",
						hl = {
							fg = util.darken(base_color, 0.8),
							bg = util.darken(base_color, 0.8),
						},
					},
					{
						str = "slant_left",
						hl = {
							fg = "bg",
							bg = util.darken(base_color, 0.8),
						},
					},
				},
			}
		end

		local lsp_info_component = function()
			return {
				provider = "lsp_client_names",
				short_provider = function()
					return ""
				end,
				hl = function()
					return {
						fg = get_vim_color(0.8),
						bg = get_vim_color(0.3),
					}
				end,
				left_sep = get_left_sep(0.3),
				right_sep = get_right_sep(0.3),
			}
		end

		local progress_info = function()
			return {
				provider = "scroll_bar",
				hl = function()
					return {
						fg = get_vim_color(0.8),
						bg = get_vim_color(0.4),
					}
				end,
				left_sep = get_left_sep(0.4),
				right_sep = get_right_sep(0.4),
			}
		end

		local location_info = function()
			return {
				provider = "position",
				hl = function()
					return {
						fg = get_vim_color(1),
						bg = get_vim_color(0.4),
					}
				end,
				left_sep = get_left_sep(0.4),
				right_sep = {
					str = " ",
					hl = function()
						return {
							fg = get_vim_color(0.4),
							bg = get_vim_color(0.4),
						}
					end,
				},
				-- right_sep = get_right_sep(0.2),
			}
		end

		local status_components = {
			active = {
				{
					vi_mode_component(),
					git_component(),
					file_component(),
					action_component(),
					blank_component(),
				},
				{
					search_component(),
					breadcrumbs_component(),
					blank_component(),
				},
				{
					lsp_component("diagnostic_errors", colors.red),
					-- lsp_component("diagnostic_warnings", colors.orange),
					lsp_component("diagnostic_warnings", "#af3a03"),
					lsp_component("diagnostic_hints", colors.green2),
					lsp_component("diagnostic_info", colors.blue),
					lsp_info_component(),
					progress_info(),
					location_info(),
				},
			},
			inactive = {},
		}

		require("feline").setup({
			components = status_components,
		})

		require("feline").use_theme(
			{
				bg = "#3c3836"
			}
		)

		local winbar_components = {
			active = {},
			inactive = {},
		}
		-- require("feline").winbar.setup({
		-- 	components = winbar_components,
		-- })
	end,
}
