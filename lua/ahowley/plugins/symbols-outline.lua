require("ahowley.remap")

return {
	"hedyhli/outline.nvim",
	config = function()
		require("outline").setup({
			-- Your setup opts here (leave empty to use defaults)
		})

		map("n", l("Tu"), "<cmd>Outline<CR>", "[T]oggle o[u]tline")
	end,
}
