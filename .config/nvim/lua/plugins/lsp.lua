---@diagnostic disable-next-line: unused-local
local function on_attach(client, bufnr)
	-- X.set_default_on_buffer(client, bufnr)
	local presentLspSignature, lsp_signature = pcall(require, "lsp_signature")
	if presentLspSignature then lsp_signature.on_attach({ floating_window = false, timer_interval = 500 }) end

	local cmp = require("cmp")
	---@diagnostic disable-next-line: missing-parameter
	if cmp.visible() then cmp.mapping.complete() end
end
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
			"b0o/schemastore.nvim",
			{ "folke/neodev.nvim", config = true },
			{ "j-hui/fidget.nvim", config = true },
			{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim", version = false, config = true },
		},
		event = "LazyFile",
		opts = {
			lsp = {
				virtual_text = false,
				virtual_lines = true,
				signs = {
					active = require("config.icons"),
				},
				flags = { debounce_text_changes = 200 },
				update_in_insert = false,
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
			},
			servers = {
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
							telemetry = { enable = false },
							workspace = {
								checkThirdParty = false,
								library = {
									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
								},
							},
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
					root_dir = function() return require("lspconfig.util").find_node_modules_ancestor end,
					single_file_support = true,
				},
				yamlls = {},
			},
		},
		init = function(plugin)
			for name, sign in pairs(require("config.icons").lsp.diagnostics) do
				vim.fn.sign_define(name, { texthl = name, text = sign, numhl = "" })
			end
			vim.lsp.set_log_level("error")
			vim.diagnostic.config(plugin.opts.lsp)
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "shadow" })
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "shadow" })
		end,
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			local cmp_lsp = require("cmp_nvim_lsp")
			local default_lsp_config = {
				on_attach = on_attach,
				capabilities = cmp_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
				flags = { debounce_text_changes = 200, allow_incremental_sync = true },
			}

			require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(opts.servers) })
			lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, opts.lsp)

			for server_name, server_config in pairs(opts.servers) do
				local merged_config = vim.tbl_deep_extend("force", default_lsp_config, server_config)
				lspconfig[server_name].setup(merged_config)

				if server_name == "rust_analyzer" then
					local rust_tools_present, rust_tools = pcall(require, "rust-tools")
					if rust_tools_present then rust_tools.setup({ server = merged_config }) end
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
			format_on_save = { timeout_ms = 500, lsp_fallback = true },
		},
		keys = {
			{
				"<leader>bf",
				function() require("conform").format({ async = true, lsp_fallback = true }) end,
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
			{ "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds" },
			{ "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
			{
				"zK",
				function() return require("ufo").peekFoldedLinesUnderCursor() or vim.lsp.buf.hover() end,
				desc = "Peek Fold",
			},
		},
		opts = {
			---@diagnostic disable-next-line: unused-local
			provider_selector = function(bufnr, filetype, buftype) return { "lsp", "indent" } end,
		},
	},
	{
		"windwp/nvim-autopairs",
		opts = { enable_check_bracket_pairs = false, fast_wrap = {} },
		build = function()
			local npairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")
			local cond = require("nvim-autopairs.conds")

			npairs.add_rules({
				Rule(" ", " ", "lua")
					:with_pair(function(opts)
						local pair = opts.line:sub(opts.col - 1, opts.col)
						return vim.tbl_contains({ "{}" }, pair)
					end)
					:with_move(cond.none())
					:with_cr(cond.none())
					:with_del(function(opts)
						local col = vim.api.nvim_win_get_cursor(0)[2]
						return vim.tbl_contains({ "{ }" }, opts.line:sub(col - 1, col + 2))
					end),
			})
			-- For each pair of brackets we will add another rule
			npairs.add_rules({
				-- Each of these rules is for a pair with left-side '( ' and right-side ' )' for each bracket type
				Rule("{ ", " }", "lua")
					:with_pair(cond.none())
					:with_move(function(opts) return opts.char == "}" end)
					:with_del(cond.none())
					:use_key("}")
					-- Removes the trailing whitespace that can occur without this
					:replace_map_cr(
						function(_) return "<C-c>2xi<CR><C-c>O" end
					),
			})
		end,
	},
	-- UI
	{ "j-hui/fidget.nvim", config = true },
	{
		"glepnir/lspsaga.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "LazyFile",
		opts = {
			implement = { enable = true, lang = { "rust" } },
			lightbulb = { sign = false },
			code_action = { extend_gitsigns = true },
		},
		keys = {
			{ "ga", "<cmd>Lspsaga finder<cr>", desc = "Open symbol finder" },
			{ "ghi", "<cmd>Lspsaga finder imp<cr>", desc = "Find all implementations" },
			{ "ghr", "<cmd>Lspsaga finder ref<cr>", desc = "Find all references" },
			{ "ghd", "<cmd>Lspsaga finder def<cr>", desc = "Find all definitions" },
			{ "gr", "<cmd>Lspsaga rename<cr>", desc = "Rename symbol" },
			{ "gR", "<cmd>Lspsaga rename ++project<cr>", desc = "Rename symbol (project)" },
			{ "gd", "<cmd>Lspsaga peek_definition<cr>", desc = "Peek definition" },
			{ "gD", "<cmdLspsaga goto_definition<cr>", desc = "Goto definition" },
			{ "gt", "<cmd>Lspsaga peek_type_definition<cr>", desc = "Peek type definition" },
			{ "gT", "<cmd>Lspsaga goto_type_definition<cr>", desc = "Goto type definition" },
			{ "<leader>sl", "<cmd>Lspsaga show_line_diagnostics ++unfocus<cr>", desc = "Show line diagnostics" },
			{ "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<cr>", desc = "Show cursor diagnostics" },
			{ "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<cr>", desc = "Show buffer diagnostics" },
			{ "<leader>sw", "<cmd>TroubleToggle<cr>", desc = "Show workspace diagnostics" },
			{ "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "Jump to previous diagnostic" },
			{ "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Jump to next diagnostic" },
			{ "go", "<cmd>Lspsaga outline<cr>", desc = "Show outline" },
			{ "<A-d>", "<cmd>Lspsaga term_toggle<cr>", desc = "Toggle floating terminal", mode = { "n", "t" } },
			{ "<leader>a", "<cmd>Lspsaga code_action<cr>", desc = "Show code actions", mode = { "n", "v" } },
		},
	},
}
