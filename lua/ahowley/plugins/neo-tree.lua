require("ahowley.remap")

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		require("neo-tree").setup({
			window = {
				position = "current",
			},
		})
		map("n", l("lf"), "<cmd>Neotree filesystem reveal current<CR>", "[l]ist [f]iles")
		map("n", l("fe"), "<cmd>Neotree filesystem reveal current<CR>", "[f]ile [e]xplore")
		map("n", l("Te"), "<cmd>Neotree filesystem toggle right<CR>", "[T]oggle [e]xplore")
	end,
}
