return {
	"smjonas/inc-rename.nvim",
	config = function()
		require("inc_rename").setup()

		require("ahowley.remap")
		map("n", l("cr"), function()
			return ":IncRename " .. vim.fn.expand("<cword>")
		end, "[c]ode [r]ename symbol", { expr = true })
	end,
}
