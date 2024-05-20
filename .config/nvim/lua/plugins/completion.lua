local function next_completion(cmp, luasnip)
	return function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif luasnip.expand_or_jumpable() then
			require("lspkind")(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
		else
			fallback()
		end
	end
end

local function prev_completion(cmp, luasnip)
	return function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		elseif luasnip.jumpable(-1) then
			require("lspkind")(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
		else
			fallback()
		end
	end
end
local function completion_format()
	local kind = require("lspkind")
	local icons = require("config.icons").lsp
	return kind.cmp_format({
		mode = "symbol_text",
		maxwidth = function() return math.floor(0.3 * vim.o.columns) end,
		ellipsis_char = "",
		show_labelDetails = true,
		before = function(entry, item)
			local k = item.kind
			item.kind = string.format("%s %s", vim.tbl_deep_extend("force", kind.symbol_map, icons.kind)[k], k)
			item.menu = icons.menu[entry.source_name]
			return item
		end,
	})
end
return {
	{ "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
	{ "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
	{
		"hrsh7th/nvim-cmp",
		version = false,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"windwp/nvim-autopairs",
			"saadparwaiz1/cmp_luasnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
			"onsails/lspkind-nvim",
			"roobert/tailwindcss-colorizer-cmp.nvim",
			"L3MON4D3/LuaSnip",
		},
		opts = function()
			return {
				enabled = true,
				experimental = { ghost_text = true },
				---@diagnostic disable-next-line: missing-fields
				snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
				formatting = { format = {} },
				sources = {
					{ name = "nvim_lsp_signature_help", group_index = 1 },
					{ name = "luasnip", max_item_count = 5, group_index = 1 },
					{ name = "nvim_lsp", max_item_count = 20, group_index = 1 },
					{ name = "nvim_lua", group_index = 1 },
					{ name = "path", group_index = 2 },
					{ name = "buffer", keyword_length = 2, max_item_count = 5, group_index = 2 },
				},
			}
		end,
		config = function(_, opts)
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			opts.formatting.format = completion_format()
			opts.window = {
				completion = cmp.config.window.bordered({
					winhighlight = "Normal:Normal,FloatBorder:LspBorderBG,CursorLine:PmenuSel,Search:None",
				}),
				documentation = cmp.config.window.bordered({
					winhighlight = "Normal:Normal,FloatBorder:LspBorderBG,CursorLine:PmenuSel,Search:None",
				}),
			}
			opts.mapping = {
				["<C-f>"] = cmp.mapping.scroll_docs(-4),
				["<C-b>"] = cmp.mapping.scroll_docs(4),
				["<Esc>"] = cmp.mapping.close(),
				["<C-l>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
				["<C-j>"] = next_completion(cmp, luasnip),
				["<C-k>"] = prev_completion(cmp, luasnip),
				["<C-Space>"] = cmp.mapping.complete(), ---@diagnostic disable-line: missing-parameter
			}
			---@diagnostic disable-next-line
			cmp.setup(opts)

			local presentAutopairs, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
			if presentAutopairs then
				cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
			end
		end,
	},
}
