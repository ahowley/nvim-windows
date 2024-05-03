require("ahowley.remap")

local signs = {
	Error = " ",
	Warn = " ",
	Hint = " ",
	Info = " ",
}
local severity = vim.diagnostic.severity
local function format_diagnostic(diagnostic)
	local message = diagnostic.message
	if diagnostic.severity == severity.ERROR then
		return signs.Error .. message
	elseif diagnostic.severity == severity.INFO then
		return signs.Info .. message
	elseif diagnostic.severity == severity.WARN then
		return signs.Warn .. message
	elseif diagnostic.severity == severity.HINT then
		return signs.Hint .. message
	else
		return message
	end
end

return { -- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim
		{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
		"williamboman/mason-lspconfig.nvim",

		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Useful status updates for LSP.
		-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
		{ "j-hui/fidget.nvim", opts = {} },

		-- `neodev` configures Lua LSP for your Neovim config, runtime and plugins:wq
		-- used for completion, annotations and signatures of Neovim apis
		{ "folke/neodev.nvim", opts = {} },
		{
			"SmiteshP/nvim-navic",
			opts = {
				lsp = { auto_attach = true },
			},
		},
		{
			"SmiteshP/nvim-navbuddy",
			dependencies = {
				"SmiteshP/nvim-navic",
				"MunifTanjim/nui.nvim",
			},
			opts = { lsp = { auto_attach = true } },
		},
		{
			"lewis6991/hover.nvim",
			config = function()
				require("hover").setup({
					init = function()
						require("hover.providers.lsp")
						require("hover").register({
							name = "Diagnostic",
							priority = 1100,
							enabled = function()
								return true
							end,
							execute = function(opts, done)
								if opts == nil or opts == false then
									done(nil)
									return
								end

								local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
								local current_line_diagnostics = vim.diagnostic.get(0, {
									lnum = row - 1,
								})

								local diagnostic = current_line_diagnostics[1]
								if diagnostic == nil then
									done(nil)
									return
								end

								print(format_diagnostic(diagnostic))

								done({
									lines = vim.split(format_diagnostic(diagnostic), "\n"),
									filetype = "markdown",
								})
							end,
						})
					end,
					preview_opts = {
						border = "rounded",
					},
					preview_window = true,
					title = false,
					mouse_providers = {
						"LSP",
					},
					mouse_delay = 300,
				})
			end,
		},
	},
	config = function()
		map("n", l("fr"), vim.lsp.buf.rename, "[f]ile [r]ename")
		-- map("n", l("ca"), vim.lsp.buf.code_action, "[c]ode [a]ction")
		map("n", l("ch"), require("hover").hover, "[c]ode [h]over")
		-- map("n", l("ch"), vim.lsp.buf.hover, "[c]ode [h]over")
		-- map("n", l("gD"), vim.lsp.buf.declaration, "[g]oto [d]eclaration")
		map("n", l("cH"), require("hover").hover_select, "[c]ode [H]over select")
		map("n", "<C-p>", function()
			---@diagnostic disable-next-line: missing-parameter
			require("hover").hover_switch("previous")
		end, "hover.nvim (previous source)")
		map("n", "<C-n>", function()
			---@diagnostic disable-next-line: missing-parameter
			require("hover").hover_switch("next")
		end, "hover.nvim (next source)")
		map("n", "<MouseMove>", require("hover").hover_mouse, "hover.nvim (mouse)")
		map("n", l("Ti"), function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, "[T]oggle [i]nlay hints")
		map("n", l("cn"), "<cmd>Navbuddy<CR>", "[c]ode [n]avigate")

		--  This function gets run when an LSP attaches to a particular buffer.
		--    That is to say, every time a new file is opened that is associated with
		--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
		--    function will be executed to configure the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.documentHighlightProvider then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})
				end
			end,
		})

		vim.api.nvim_create_autocmd("LspDetach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
			callback = function(event)
				vim.lsp.buf.clear_references()
				vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event.buf })
			end,
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		--  Add any additional override configuration in the following tables. Available keys are:
		--  - cmd (table): Override the default command used to start the server
		--  - filetypes (table): Override the default list of associated filetypes for the server
		--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
		--  - settings (table): Override the default settings passed when initializing the server.
		--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
		local servers = {
			clangd = {},
			gopls = {},
			pyright = {},
			rust_analyzer = {},
			csharp_ls = {},
			cssls = {},
			dockerls = {},
			emmet_ls = {},
			html = {},
			jsonls = {},
			sqlls = {},
			-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs

			lua_ls = {
				-- cmd = {...},
				-- filetypes = { ...},
				-- capabilities = {},
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
						-- diagnostics = { disable = { 'missing-fields' } },
					},
				},
			},
		}

		-- Ensure the servers and tools above are installed
		--  To check the current status of installed tools and/or manually install
		--  other tools, you can run
		--    :Mason
		--
		--  You can press `g?` for help in this menu.
		require("mason").setup()

		-- You can add other tools here that you want Mason to install
		-- for you, so that they are available from within Neovim.
		-- local ensure_installed = vim.tbl_keys(servers or {})
		-- vim.list_extend(ensure_installed, {
		-- 	"stylua", -- Used to format Lua code
		-- })
		-- require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					-- This handles overriding only values explicitly passed
					-- by the server configuration above. Useful when disabling
					-- certain features of an LSP (for example, turning off formatting for tsserver)
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
