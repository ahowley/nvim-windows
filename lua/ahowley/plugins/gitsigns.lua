require("ahowley.remap")

return { -- Adds git related signs to the gutter, as well as utilities for managing changes
	"lewis6991/gitsigns.nvim",
	config = function()
		local gitsigns = require("gitsigns")
		gitsigns.setup()

		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end)

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end)

		-- Actions
		map("n", "<leader>hs", gitsigns.stage_hunk, "[h]unk [s]tage")
		map("n", "<leader>hr", gitsigns.reset_hunk, "[h]unk [reset]")
		map("v", "<leader>hs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "[h]unk [s]tage")
		map("v", "<leader>hr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "[h]unk [r]eset")
		map("n", "<leader>hS", gitsigns.stage_buffer, "[h]unk [S]tage buffer")
		map("n", "<leader>hu", gitsigns.undo_stage_hunk, "[h]unk [u]ndo stage")
		map("n", "<leader>hR", gitsigns.reset_buffer, "[h]unk [R]eset buffer")
		map("n", "<leader>hp", gitsigns.preview_hunk, "[h]unk [p]review")
		map("n", "<leader>hb", gitsigns.toggle_current_line_blame, "[h]unk show [b]lame")
		map("n", "<leader>hd", gitsigns.diffthis, "[h]unk [d]iff this")
		map("n", "<leader>hD", function()
			gitsigns.diffthis("~")
		end, "[h]unk [D]iff all")
	end,
}
