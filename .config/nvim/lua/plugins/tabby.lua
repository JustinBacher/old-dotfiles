
return {
	'nanozuki/tabby.nvim',
	event = 'VimEnter',
	init = function()
		vim.o.showtabline = 2
	end,
	dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
	config = function()
		local util = require('tabby.util')

		local hl_tabline_fill = util.extract_nvim_hl('lualine_c_normal') -- 背景
		local hl_tabline = util.extract_nvim_hl('lualine_b_normal')
		local hl_tabline_sel = util.extract_nvim_hl('lualine_a_normal')  -- 高亮

		local function tab_label(tabid, active)
			local icon = active and ' ' or ' '
			local number = vim.api.nvim_tabpage_get_number(tabid)
			local name = util.get_tab_name(tabid)
			return string.format(' %s %d: %s ', icon, number, name)
		end

		local presets = {
		}

		require('tabby').setup({
			tabline = {
				hl = 'lualine_c_normal',
				layout = 'tab_only',
				head = {
					{ '  ', hl = { fg = hl_tabline.fg, bg = hl_tabline.bg } },
					{ '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
				},
				active_tab = {
					label = function(tabid)
						return {
							tab_label(tabid, true),
							hl = { fg = hl_tabline.fg, bg = hl_tabline_sel.bg },
						}
					end,
					left_sep = { '', hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
					right_sep = { '', hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
				},
				inactive_tab = {
					label = function(tabid)
						return {
							tab_label(tabid, false),
							hl = { fg = hl_tabline.fg, bg = hl_tabline_fill.bg },
						}
					end,
					left_sep = { ' ', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
					right_sep = { ' ', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
				},
			}
		})
	end,
}
