return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"b0o/schemastore.nvim",
			"hrsh7th/nvim-cmp",
			{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim", name = "lsp_lines" },
			{ "folke/neodev.nvim", config = true },
			{ "j-hui/fidget.nvim", config = true },
		},
		event = "LazyFile",
		config = function()
			local l = require("lsp_lines")
			for k, v in pairs(l) do
				print(tostring(k), tostring(v))
			end
			-- require("lsp_lines").setup()

			local lspconfig = require("lspconfig")
			local presentCmpNvimLsp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
			local presentLspSignature, lsp_signature = pcall(require, "lsp_signature")

			vim.lsp.set_log_level("error")

			local function on_attach(client, bufnr)
				-- X.set_default_on_buffer(client, bufnr)

				if presentLspSignature then
					lsp_signature.on_attach({ floating_window = false, timer_interval = 500 })
				end
			end

			local signs = {
				{ name = "DiagnosticSignError", text = " " },
				{ name = "DiagnosticSignWarn", text = " " },
				{ name = "DiagnosticSignHint", text = " " },
				{ name = "DiagnosticSignInfo", text = " " },
			}
			for _, sign in ipairs(signs) do
				vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
			end

			local config = {
				virtual_text = false, -- appears after the line
				virtual_lines = false, -- appears under the line
				signs = {
					active = signs,
				},
				flags = {
					debounce_text_changes = 200,
				},
				update_in_insert = true,
				underline = true,
				severity_sort = true,
				float = {
					focus = false,
					focusable = false,
					style = "minimal",
					border = "shadow",
					source = "always",
					header = "",
					prefix = "",
				},
			}
			lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, config)
			vim.diagnostic.config(config)

			local border = {
				border = "shadow",
			}
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.hover, border)
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, border)

			local capabilities
			if presentCmpNvimLsp then
				capabilities = cmp_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
			else
				capabilities = vim.lsp.protocol.make_client_capabilities()
			end

			local servers = {
				dockerls = {},
				html = {},
				jsonls = {},
				lua_ls = {
					on_attach = function(client, bufnr)
						on_attach(client, bufnr)
						client.server_capabilities.document_formatting = false
						client.server_capabilities.document_range_formatting = false
					end,
					settings = {
						Lua = {
							hint = { enable = true },
							runtime = { version = "LuaJIT" },
							diagnostics = { globals = { "vim" } },
							workspace = {
								checkThirdParty = false,
								library = {
									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
								},
							},
							telemetry = { enable = false },
						},
					},
				},
				pylsp = {},
				rust_analyzer = {},
				tailwindcss = {},
				terraformls = {},
				tflint = {},
				tsserver = {
					on_attach = function(client, bufnr)
						on_attach(client, bufnr)
						client.server_capabilities.document_formatting = true
					end,
					cmd = { "typescript-language-server", "--stdio" },
					filetypes = {
						"javascript",
						"javascriptreact",
						"javascript.jsx",
						"typescript",
						"typescriptreact",
						"typescript.tsx",
					},
					init_options = { hostInfo = "neovim" },
					-- root_dir = util.root_pattern("package.json", "package-lock.json", "tsconfig.json", "jsconfig.json", ".git"),
					root_dir = require("lspconfig.util").find_node_modules_ancestor,
					single_file_support = true,
				},
				yamlls = {},
			}

			local default_lsp_config = {
				on_attach = on_attach,
				capabilities = capabilities,
				flags = {
					debounce_text_changes = 200,
					allow_incremental_sync = true,
				},
			}

			local server_names = {}
			for server_name, _ in pairs(servers) do
				table.insert(server_names, server_name)
			end

			local present_mason, mason = pcall(require, "mason-lspconfig")
			if present_mason then
				mason.setup({ ensure_installed = server_names })
			end

			for server_name, server_config in pairs(servers) do
				local merged_config = vim.tbl_deep_extend("force", default_lsp_config, server_config)
				lspconfig[server_name].setup(merged_config)

				if server_name == "rust_analyzer" then
					local present_rust_tools, rust_tools = pcall(require, "rust-tools")
					if present_rust_tools then
						rust_tools.setup({ server = merged_config })
					end
				end
			end
		end,
	},
	{
		"stevearc/conform.nvim",
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				lua = { "luaformatter", "stylua" },
				nix = { "alejandra" },
				python = { "isort", "black" },
				cpp = { "astyle" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
		keys = {
			{
				"<leader>bf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				desc = "Format buffer",
				mode = { "n", "v" },
			},
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		event = "LazyFile",
		init = function()
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
		end,
		keys = {
			{
				"zR",
				function()
					require("ufo").openAllFolds()
				end,
				desc = "Open all folds",
			},
			{
				"zM",
				function()
					require("ufo").closeAllFolds()
				end,
				desc = "Close all folds",
			},
			{
				"zK",
				function()
					if not require("ufo").peekFoldedLinesUnderCursor() then
						vim.lsp.buf.hover()
					end
				end,
				desc = "Peek Fold",
			},
		},
		opts = {
			provider_selector = function(bufnr, filetype, buftype) ---@diagnostic disable-line: unused-local
				return { "lsp", "indent" }
			end,
		},
	},
	-- Completion
	{
		"hrsh7th/nvim-cmp",
		event = "LazyFile",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
			"windwp/nvim-autopairs",
			"onsails/lspkind-nvim",
			{ "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
		},
		config = function()
			local cmp = require("cmp")
			---@diagnostic disable-next-line
			cmp.setup({
				enabled = true,
				window = {
					completion = cmp.config.window.bordered({
						winhighlight = "Normal:Normal,FloatBorder:LspBorderBG,CursorLine:PmenuSel,Search:None",
					}),
					documentation = cmp.config.window.bordered({
						winhighlight = "Normal:Normal,FloatBorder:LspBorderBG,CursorLine:PmenuSel,Search:None",
					}),
				},
				---@diagnostic disable-next-line
				view = {
					entries = "bordered",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				formatting = {
					format = require("lspkind").cmp_format({
						mode = "symbol", -- show only symbol annotations
						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						-- can also be a function to dynamically calculate max width such as
						-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
						ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
						show_labelDetails = true, -- show labelDetails in menu. Disabled by default

						-- The function below will be called before any actual modifications from lspkind
						-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
						-- before = function (entry, vim_item)
						-- 	return vim_item
						-- end
					}),
				},
				mapping = {
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-u>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.close(),
					["<Esc>"] = cmp.mapping.close(),
					["<C-y>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
					["<C-n>"] = function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif require("luasnip").expand_or_jumpable() then
							vim.fn.feedkeys(
								vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
								""
							)
						else
							fallback()
						end
					end,
					["<C-p>"] = function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif require("luasnip").jumpable(-1) then
							vim.fn.feedkeys(
								vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true),
								""
							)
						else
							fallback()
						end
					end,
				},
				sources = {
					{ name = "nvim_lsp_signature_help", group_index = 1 },
					{ name = "luasnip", max_item_count = 5, group_index = 1 },
					{ name = "nvim_lsp", max_item_count = 20, group_index = 1 },
					{ name = "nvim_lua", group_index = 1 },
					{ name = "path", group_index = 2 },
					{ name = "buffer", keyword_length = 2, max_item_count = 5, group_index = 2 },
				},
			})
			local presentAutopairs, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
			if presentAutopairs then
				cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
			end
		end,
	},
	-- UI
	{
		"j-hui/fidget.nvim",
		config = true,
	},
	{
		"glepnir/lspsaga.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "LazyFile",
		opts = {
			implement = {
				enable = true,
				lang = { "rust" },
			},
			lightbulb = {
				sign = false,
			},
			code_action = {
				extend_gitsigns = true,
			},
		},
		keys = {
			{ "ga", "<cmd>Lspsaga finder<cr>", desc = "Open symbol finder" },
			{ "ghi", "<cmd>Lspsaga finder imp<cr>", desc = "Find all implementations" },
			{ "ghr", "<cmd>Lspsaga finder ref<cr>", desc = "Find all references" },
			{ "ghd", "<cmd>Lspsaga finder def<cr>", desc = "Find all definitions" },
			{ "gr", "<cmd>Lspsaga rename<cr>", desc = "Rename symbol" },
			{ "gR", "<cmd>Lspsaga rename ++project<cr>", desc = "Rename symbol (project)" },
			{ "gd", "<cmd>Lspsaga peek_definition<cr>", desc = "Peek definition" },
			{ "gD", "<cmd>Lspsaga goto_definition<cr>", desc = "Goto definition" },
			{ "gt", "<cmd>Lspsaga peek_type_definition<cr>", desc = "Peek type definition" },
			{ "gT", "<cmd>Lspsaga goto_type_definition<cr>", desc = "Goto type definition" },
			{ "<leader>sl", "<cmd>Lspsaga show_line_diagnostics ++unfocus<cr>", desc = "Show line diagnostics" },
			{ "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<cr>", desc = "Show cursor diagnostics" },
			{ "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<cr>", desc = "Show buffer diagnostics" },
			{ "<leader>sw", "<cmd>TroubleToggle<cr>", desc = "Show workspace diagnostics" },
			{ "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "Jump to previous diagnostic" },
			{ "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Jump to next diagnostic" },
			{ "go", "<cmd>Lspsaga outline<cr>", desc = "Show outline" },
			{
				"[e",
				function()
					require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
				end,
				desc = "Jump to previous error",
			},
			{
				"]e",
				function()
					require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
				end,
				desc = "Jump to next error",
			},
			{
				"[w",
				function()
					require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.WARN })
				end,
				desc = "Jump to previous warning",
			},
			{
				"]w",
				function()
					require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.WARN })
				end,
				desc = "Jump to next warning",
			},
			{
				"<A-d>",
				"<cmd>Lspsaga term_toggle<cr>",
				desc = "Toggle floating terminal",
				mode = { "n", "t" },
			},
			{
				"<leader>a",
				"<cmd>Lspsaga code_action<cr>",
				desc = "Show code actions",
				mode = { "n", "v" },
			},
		},
	},
}
