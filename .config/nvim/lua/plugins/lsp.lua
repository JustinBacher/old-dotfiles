return {
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = { "BufEnter", "CmdlineEnter", "InsertEnter" },
		dependencies = {
			{ "williamboman/mason.nvim", lazy = true},
			{ "williamboman/mason-lspconfig.nvim", lazy = true},
			{ "hrsh7th/cmp-nvim-lsp", lazy = true},
			{ "hrsh7th/cmp-buffer", lazy = true},
			{ "hrsh7th/cmp-path", lazy = true},
			{ "hrsh7th/cmp-cmdline", lazy = true},
			{ "hrsh7th/nvim-cmp", lazy = true},
			{ "cmp-nvim-lsp-signature-help", lazy = true},
			{ "L3MON4D3/LuaSnip", lazy = true},
			{ "saadparwaiz1/cmp_luasnip", lazy = true},
			{ "j-hui/fidget.nvim", lazy = true},
			{ "onsails/lspkind.nvim", lazy = true},
		},
		config = function()
			local cmp = require("cmp")
			local cmp_lsp = require("cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

			require("fidget").setup({})
			require("mason").setup()
			require("mason-lspconfig").setup({
				automatic_installation = true,
				ensure_installed = {
					"lua_ls",
					"rust_analyzer",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({ capabilities = capabilities })
					end,
					lua_ls = function()
						require("lspconfig").lua_ls.setup({
							capabilities = capabilities,
							settings = {
								Lua = {
									runtime = { version = "Lua 5.1" },
									diagnostics = { globals = { "vim", "it", "describe", "before_each", "after_each" } },
								},
							},
						})
					end,
				},
			})
			
			local get_bufnrs =  function()
				return vim.api.nvim_list_bufs()
			end
			-- `/` cmdline setup.
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = "buffer", get_bufnrs = get_bufnrs } },
			})

			-- `:` cmdline setup.
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
				matching = { disallow_symbol_nonprefix_matching = false }
			})

			local luasnip = require("luasnip")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			cmp.setup({
				snippet = {expand = function(args) luasnip.lsp_expand(args.body) end },
				mapping = cmp.mapping.preset.insert({
					["<tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.mapping.select_prev_item(cmp_select),
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.mapping.select_next_item(cmp_select),
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<cr>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							if luasnip.expandable() then
								luasnip.expand()
							else
								cmp.confirm({ select = true })
							end
						else
							fallback()
						end
					end),
				}),
				window = {
					completion = {
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
						col_offset = -3,
						side_padding = 0,
					},
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = "    (" .. (strings[2] or "") .. ")"
						return kind
					end,
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = 'nvim_lsp_signature_help' }
					{ name = "luasnip", keyword_length = 2 },
					{ name = "buffer", keyword_length = 3, get_bufnrs = get_bufnrs },
					{ name = "path" },
				})

				vim.diagnostic.config({
					update_in_insert = true,
					severity_sort = true,
					float = {
						focusable = false,
						style = "minimal",
						border = "rounded",
						source = "always",
						header = "",
						prefix = "",
					},
				})
			end,
		build = function()
			local hl = vim.api.nvim_set_hl
			hl(0, "PmenuSel", { bg = "#282C34", fg = "NONE" })
			hl(0, "Pmenu", { fg = "#C5CDD9", bg = "#22252A" })

			hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
			hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
			hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
			hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })

			hl(0, "CmpItemKindField", { fg = "#EED8DA", bg = "#B5585F" })
			hl(0, "CmpItemKindProperty", { fg = "#EED8DA", bg = "#B5585F" })
			hl(0, "CmpItemKindEvent", { fg = "#EED8DA", bg = "#B5585F" })

			hl(0, "CmpItemKindText", { fg = "#C3E88D", bg = "#9FBD73" })
			hl(0, "CmpItemKindEnum", { fg = "#C3E88D", bg = "#9FBD73" })
			hl(0, "CmpItemKindKeyword", { fg = "#C3E88D", bg = "#9FBD73" })

			hl(0, "CmpItemKindConstant", { fg = "#FFE082", bg = "#D4BB6C" })
			hl(0, "CmpItemKindConstructor", { fg = "#FFE082", bg = "#D4BB6C" })
			hl(0, "CmpItemKindReference", { fg = "#FFE082", bg = "#D4BB6C" })

			hl(0, "CmpItemKindFunction", { fg = "#EADFF0", bg = "#A377BF" })
			hl(0, "CmpItemKindStruct", { fg = "#EADFF0", bg = "#A377BF" })
			hl(0, "CmpItemKindClass", { fg = "#EADFF0", bg = "#A377BF" })
			hl(0, "CmpItemKindModule", { fg = "#EADFF0", bg = "#A377BF" })
			hl(0, "CmpItemKindOperator", { fg = "#EADFF0", bg = "#A377BF" })

			hl(0, "CmpItemKindVariable", { fg = "#C5CDD9", bg = "#7E8294" })
			hl(0, "CmpItemKindFile", { fg = "#C5CDD9", bg = "#7E8294" })

			hl(0, "CmpItemKindUnit", { fg = "#F5EBD9", bg = "#D4A959" })
			hl(0, "CmpItemKindSnippet", { fg = "#F5EBD9", bg = "#D4A959" })
			hl(0, "CmpItemKindFolder", { fg = "#F5EBD9", bg = "#D4A959" })

			hl(0, "CmpItemKindMethod", { fg = "#DDE5F5", bg = "#6C8ED4" })
			hl(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = "#6C8ED4" })
			hl(0, "CmpItemKindEnumMember", { fg = "#DDE5F5", bg = "#6C8ED4" })

			hl(0, "CmpItemKindInterface", { fg = "#D8EEEB", bg = "#58B5A8" })
			hl(0, "CmpItemKindColor", { fg = "#D8EEEB", bg = "#58B5A8" })
			hl(0, "CmpItemKindTypeParameter", { fg = "#D8EEEB", bg = "#58B5A8" })
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			local ls = require("luasnip")
			ls.filetype_extend("javascript", { "jsdoc" })
		end,
	},
	{
		"Bekaboo/dropbar.nvim",
		lazy = true,
		branch = "feat-winbar-background-highlight",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
		},
	},
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = {
		  { "<C-P>", "<cmd>Outline<cr>", desc = "Toggle outline" },
		},
		opts = {
			auto_close = true,
			auto_jump = true,
		},
	  },
}
