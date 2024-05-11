local lualine_colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

return {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
        opts = {
	options = {
            theme = {
                normal = {
                  a = { fg = lualine_colors.black, bg = lualine_colors.violet },
                  b = { fg = lualine_colors.white, bg = lualine_colors.grey },
                  c = { fg = lualine_colors.white },
                },
              
                insert = { a = { fg = lualine_colors.black, bg = lualine_colors.blue } },
                visual = { a = { fg = lualine_colors.black, bg = lualine_colors.cyan } },
                replace = { a = { fg = lualine_colors.black, bg = lualine_colors.red } },
              
                inactive = {
                  a = { fg = lualine_colors.white, bg = lualine_colors.black },
                  b = { fg = lualine_colors.white, bg = lualine_colors.black },
                  c = { fg = lualine_colors.white },
                },
              },
            component_separators = '',
            section_separators = { left = '', right = '' },
          },
          sections = {
            lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
            lualine_b = { 'filename', 'branch' },
            lualine_c = {
              '%=', --[[ add your center compoentnts here in place of this comment ]]
            },
            lualine_x = {},
            lualine_y = { 'filetype', 'progress' },
            lualine_z = {
              { 'location', separator = { right = '' }, left_padding = 2 },
            },
          },
          inactive_sections = {
            lualine_a = { 'filename' },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = { 'location' },
          },
          tabline = {},
          extensions = {},
    }
	}

