require("ahowley.remap")

return {
	"rmagatti/goto-preview",
	config = function()
		require("goto-preview").setup({
			width = 120,
			height = 25,
		})
		map(
			"n",
			l("gp"),
			"<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
			"[g]oto [p]review definition"
		)
		map(
			"n",
			l("gt"),
			"<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
			"[g]oto [t]ype definition"
		)
		map(
			"n",
			l("gi"),
			"<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
			"[g]oto [i]mplementation"
		)
		map("n", l("gD"), "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>", "[g]oto [D]eclaration")
		map("n", l("gq"), "<cmd>lua require('goto-preview').close_all_win()<CR>", "[g]oto preview [q]uit")
		map("n", l("gr"), "<cmd>lua require('goto-preview').goto_preview_references()<CR>", "[g]oto [r]eferences")
	end,
}
