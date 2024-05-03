return {
	"ziontee113/syntax-tree-surfer",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {},
	keys = {
		{
			"vx",
			"<cmd>STSSelectMasterNode<CR>",
			desc = "select main node",
			mode = { "n" },
		},
		{
			"vn",
			"<cmd>STSSelectCurrentNode<CR>",
			desc = "select current node",
			mode = { "n" },
		},
		{
			l("J"),
			"<cmd>STSSelectMasterNode<CR><cmd>STSSelectNextSiblingNode<CR><esc>`<",
			desc = "select next sibling from parent",
			mode = { "n" },
		},
		{
			l("K"),
			"<cmd>STSSelectMasterNode<CR><cmd>STSSelectPrevSiblingNode<CR><esc>`<",
			desc = "select previous sibling from parent",
			mode = { "n" },
		},
		{
			l("j"),
			"<cmd>STSSelectCurrentNode<CR><cmd>STSSelectNextSiblingNode<CR><esc>`<",
			desc = "select next sibling",
			mode = { "n" },
		},
		{
			l("k"),
			"<cmd>STSSelectCurrentNode<CR><cmd>STSSelectPrevSiblingNode<CR><esc>`<",
			desc = "select previous sibling",
			mode = { "n" },
		},
		{
			"J",
			"<cmd>STSSelectNextSiblingNode<CR>",
			desc = "select next sibling",
			mode = { "x" },
		},
		{
			"K",
			"<cmd>STSSelectPrevSiblingNode<CR>",
			desc = "select previous sibling",
			mode = { "x" },
		},
		{
			"H",
			"<cmd>STSSelectParentNode<CR>",
			desc = "select parent node",
			mode = { "x" },
		},
		{
			"L",
			"<cmd>STSSelectChildNode<CR>",
			desc = "select child node",
			mode = { "x" },
		},
		{
			"<C-j>",
			"<cmd>STSSwapNextVisual<CR>",
			desc = "swap next sibling node",
			mode = { "x" },
		},
		{
			"<C-k>",
			"<cmd>STSSwapPrevVisual<CR>",
			desc = "swap previous sibling node",
			mode = { "x" },
		},
	},
}
