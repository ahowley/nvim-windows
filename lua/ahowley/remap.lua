function l(s)
	return "<leader>" .. s
end

function send_keys(keys)
	local escaped = vim.api.nvim_replace_termcodes(keys, true, false, true)
	vim.api.nvim_feedkeys(escaped, "m", false)
end

function map(mode, binding, action, description, opts)
	opts = opts or {}
	opts.desc = description
	---@diagnostic disable-next-line: undefined-global
	opts.buffer = bufnr
	vim.keymap.set(mode, binding, action, opts)
end

function mapreg(keybind, name)
	require("which-key").register({
		[keybind] = { name = name, _ = "which_key_ignore" },
	})
end

function mappings()
	vim.g.mapleader = " "

	-- Open default vim explorer
	-- map("n", l("fe"), vim.cmd.Ex, "[f]ile [e]xplore")

	-- Clear search highlight on <Esc> in normal mode
	map("n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear search highlights")

	-- Diagnostic keymaps
	map("n", "[d", function()
		vim.diagnostic.goto_prev({ float = false })
	end, "Go to previous [d]iagnostic")
	map("n", "]d", function()
		vim.diagnostic.goto_next({ float = false })
	end, "Go to next [d]iagnostic")

	-- Easier to reach macro key
	map("n", l("m"), "@", "Run [m]acro")

	-- Toggle cmd line
	map("n", l("Tc"), function()
		if vim.o.cmdheight == 0 then
			vim.o.cmdheight = 1
		else
			vim.o.cmdheight = 0
		end
	end, "[T]oggle [c]ommand line")

	-- Modes
	map("n", l("x"), "<Esc><cmd>nohlsearch<CR>", "alternate escape key")
	map("x", "v", "<Esc>`>", "alternate escape key")
	map("x", "V", "<Esc>`<", "alternate escape key")
	map("i", "jk", "<Esc>", "alternate escape key")
	map("n", l("o"), "o<esc>", "add line below and jump")
	map("n", l("O"), "O<esc>", "add line above and jump")

	-- Navigate windows
	map("n", l("wh"), "<C-w><C-h>", "move to [w]indow on the left")
	map("n", l("wl"), "<C-w><C-l>", "move to [w]indow on the right")
	map("n", l("wk"), "<C-w><C-k>", "move to [w]indow above")
	map("n", l("wj"), "<C-w><C-j>", "move to [w]indow below")
	map("n", l("wr"), "<C-w>R", "[w]indow rotate")
	map("n", l("ws"), "<C-w>v<C-[><CR><C-w>30<<CR>", "[w]indow [s]plit")
	map("n", l("wb"), "<C-w>60><CR>", "[w]indow [b]ig")
	map("n", l("wB"), "<C-w>60<<CR>", "[w]indow not [B]ig")
	map("n", l("wo"), "<C-w>o<CR>", "[w]indow [o]nly")
	map("n", l("ww"), "<cmd>w<CR>", "[w]indow [w]rite")
	map("n", l("wq"), "<cmd>q<CR>", "[w]indow [q]uit")

	-- Navigate tabs
	map("n", l("th"), "gt<CR>", "move to [t]ab on the left")
	map("n", l("tl"), "gT<CR>", "move to [t]ab on the right")
	map("n", l("t<leader>"), "<cmd>tab ba<CR>", "edit all buffers as [t]abs")
	map("n", l("ts"), "<C-w>T<CR>", "[s]plit new [t]ab")
	map("n", l("to"), "<cmd>tabonly<CR>", "[t]ab [o]nly")
	map("n", l("tq"), "<cmd>tabc<CR>", "[t]ab [q]uit")
	map("n", l("tQ"), "<cmd>bd<CR>", "[t]ab [Q]uit all (quit buffers)")
	map("n", l("t1"), "<cmd>1tabnext<CR>", "[t]ab [1]")
	map("n", l("t2"), "<cmd>2tabnext<CR>", "[t]ab [2]")
	map("n", l("t3"), "<cmd>3tabnext<CR>", "[t]ab [3]")
	map("n", l("t4"), "<cmd>4tabnext<CR>", "[t]ab [4]")
	map("n", l("t5"), "<cmd>5tabnext<CR>", "[t]ab [5]")
	map("n", l("t6"), "<cmd>6tabnext<CR>", "[t]ab [6]")
	map("n", l("t7"), "<cmd>7tabnext<CR>", "[t]ab [7]")
	map("n", l("t8"), "<cmd>8tabnext<CR>", "[t]ab [8]")
	map("n", l("t9"), "<cmd>9tabnext<CR>", "[t]ab [9]")

	-- Special
	map("n", l("ss"), "/", "[s]earch [s]earch")
	map("n", l("sr"), function()
		vim.ui.input({ prompt = "number of lines: " }, function(num_lines)
			local search_string = ":+0,+" .. num_lines .. " s/"
			vim.ui.input({ prompt = "search for: " }, function(search_for)
				search_string = search_string .. search_for .. "/"
				vim.ui.input({ prompt = "replace with: " }, function(replace_with)
					search_string = search_string .. replace_with
					send_keys(search_string)
				end)
			end)
		end)
	end, "[s]earch [r]eplace (forward, relative)")
	map("n", l("sR"), function()
		vim.ui.input({ prompt = "number of lines: " }, function(num_lines)
			local search_string = ":-0,-" .. num_lines .. " s/"
			vim.ui.input({ prompt = "search for: " }, function(search_for)
				search_string = search_string .. search_for .. "/"
				vim.ui.input({ prompt = "replace with: " }, function(replace_with)
					search_string = search_string .. replace_with
					send_keys(search_string)
				end)
			end)
		end)
	end, "[s]earch [R]eplace (backward, relative)")
end
