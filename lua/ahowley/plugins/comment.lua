---@diagnostic disable: missing-fields
return {
	"numToStr/Comment.nvim",
	opts = {
		-- add any options here
	},
	lazy = false,
	config = function()
		require("Comment").setup({
			toggler = {
				line = "<leader>cc",
				block = "<leader>bc",
			},
			opleader = {
				line = "<leader>c",
				block = "<leader>b",
			},
			extra = {
				below = "<leader>co",
				eol = "<leader>cA",
			},
			mappings = {
				basic = true,
				extra = true,
			},
		})
	end,
}
