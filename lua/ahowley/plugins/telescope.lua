return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.6",
	-- or                            , branch = '0.1.x',
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			"nvim-telescope/telescope-fzf-native.nvim",

			-- `build` is used to run some command when the plugin is installed/updated.
			-- This is only run then, not every time Neovim starts up.
			build = "make",

			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded.
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },

		-- Useful for getting pretty icons, but requires a Nerd Font.
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		require("ahowley.remap")

		require("telescope").setup({})

		local builtin = require("telescope.builtin")

		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		map("n", l("ff"), builtin.find_files, "[f]ile [f]ind")
		map("n", l("fv"), builtin.git_files, "[f]ile [v]ersioned")

		map("n", l("sc"), builtin.commands, "[s]earch [c]ommands")
		map("n", l("sk"), builtin.keymaps, "[s]earch [k]eymaps")
		map("n", l("sg"), builtin.live_grep, "[s]earch by [g]rep")
		map("n", l("<leader>"), builtin.current_buffer_fuzzy_find, "[s]earch current buffer")

		map("n", l("lb"), builtin.buffers, "[l]ist [b]uffers")
		map("n", l("lc"), builtin.command_history, "[l]ist [c]ommand history")
		map("n", l("ls"), builtin.search_history, "[l]ist [s]earch history")
		map("n", l("lm"), builtin.marks, "[l]ist [m]arks")
		map("n", l("lq"), builtin.quickfix, "[l]ist [q]uickfixes")
		map("n", l("lj"), builtin.jumplist, "[l]ist [j]umps")
		map("n", l("ld"), builtin.diagnostics, "[l]ist [d]iagnostics")
		map("n", l("ln"), function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, "[l]ist [n]eovim config")

		-- map("n", l("gi"), builtin.lsp_implementations, "[g]oto [i]mplementation(s)")
		map("n", l("gd"), builtin.lsp_definitions, "[g]oto [d]efinition(s)")
		-- map("n", l("gt"), builtin.lsp_type_definitions, "[g]oto [t]ype definition(s)")
	end,
}
