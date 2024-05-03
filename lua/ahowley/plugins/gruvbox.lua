return { "ellisonleao/gruvbox.nvim", priority = 1000,
	event = "VimEnter",
	config = function()
		require("gruvbox").setup()
		vim.cmd.colorscheme("gruvbox")
	end
}

