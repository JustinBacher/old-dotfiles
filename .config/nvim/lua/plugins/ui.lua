local lualine_colors = {
    blue   = '#80a0ff',
    cyan   = '#79dac8',
    black  = '#080808',
    white  = '#c6c6c6',
    red    = '#ff5189',
    violet = '#d183e8',
    grey   = '#303030',
}

-- Maybe add https://github.com/stevearc/dressing.nvim if it's useful

return {
  --    _                                       _             
  --    ___    __| |   __ _   _   _       _ __   __   __ (_)  _ __ ___  
  --   / _ \  / _` |  / _` | | | | |     | '_ \  \ \ / / | | | '_ ` _ \ 
  --  |  __/ | (_| | | (_| | | |_| |  _  | | | |  \ V /  | | | | | | | |
  --   \___|  \__,_|  \__, |  \__, | (_) |_| |_|   \_/   |_| |_| |_| |_|
  --                  |___/   |___/                                     
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = "screen"
    end,
    opts = {
      bottom = {
        -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
        {
          ft = "toggleterm",
          size = { height = 0.4 },
          -- exclude floating windows
          filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ""
          end,
        },
        {
          ft = "lazyterm",
          title = "LazyTerm",
          size = { height = 0.4 },
          filter = function(buf)
            return not vim.b[buf].lazyterm_cmd
          end,
        },
        "Trouble",
        { ft = "qf", title = "QuickFix" },
        {
          ft = "help",
          size = { height = 20 },
          -- only show help buffers
          filter = function(buf)
            return vim.bo[buf].buftype == "help"
          end,
        },
        { ft = "spectre_panel", size = { height = 0.4 } },
      },
      left = {
        -- Neo-tree filesystem always takes half the screen height
        {
          title = "Neo-Tree",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
          size = { height = 0.5 },
        },
        {
          title = "Neo-Tree Git",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "git_status"
          end,
          pinned = true,
          open = "Neotree position=right git_status",
        },
        {
          title = "Neo-Tree Buffers",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "buffers"
          end,
          pinned = true,
          open = "Neotree position=top buffers",
        },
        {
          ft = "Outline",
          pinned = true,
          open = "SymbolsOutlineOpen",
        },
        -- any other neo-tree windows
        "neo-tree",
      },
      right = {
        { ft = "codecompanion", title = "Code Companion Chat", size = { width = 0.45 } },
      },
      
      exit_when_last = false,
    },
  }

    --    _   _                       _             
    --    __   __   ___  (_) | |      _ __   __   __ (_)  _ __ ___  
    --    \ \ / /  / _ \ | | | |     | '_ \  \ \ / / | | | '_ ` _ \ 
    --     \ V /  |  __/ | | | |  _  | | | |  \ V /  | | | | | | | |
    --      \_/    \___| |_| |_| (_) |_| |_|   \_/   |_| |_| |_| |_|
    --                                                              
    {
        'willothy/veil.nvim',
        lazy = true,
        dependencies = {
          -- All optional, only required for the default setup.
          -- If you customize your config, these aren't necessary.
          "nvim-telescope/telescope.nvim",
          "nvim-lua/plenary.nvim",
          "nvim-telescope/telescope-file-browser.nvim"
        }
        sections = {
            builtin.sections.animated(builtin.headers.frames_days_of_week[os.date("%A")], {
              hl = { fg = "#5de4c7" },
            }),
            builtin.sections.buttons({
                {
                  icon = "",
                  text = "Find Files",
                  shortcut = "f",
                  callback = function()
                      require("telescope.builtin").find_files()
                  end,
                },
                {
                  icon = "",
                  text = "Find Word",
                  shortcut = "w",
                  callback = function()
                      require("telescope.builtin").live_grep()
                  end,
                },
                {
                  icon = "",
                  text = "Buffers",
                  shortcut = "b",
                  callback = function()
                      require("telescope.builtin").buffers()
                  end,
                },
                {
                  icon = "",
                  text = "Config",
                  shortcut = "c",
                  callback = function()
                    require("telescope").extensions.file_browser.file_browser({
                      path = vim.fn.stdpath("config"),
                    })
                  end,
                },
              }),
              builtin.sections.oldfiles(),
            },
            mappings = {},
            startup = true,
            listed = false
          }
      }
    --    _             _       _                                   _             
    --    | |_    __ _  | |__   | |__    _   _       _ __   __   __ (_)  _ __ ___  
    --    | __|  / _` | | '_ \  | '_ \  | | | |     | '_ \  \ \ / / | | | '_ ` _ \ 
    --    | |_  | (_| | | |_) | | |_) | | |_| |  _  | | | |  \ V /  | | | | | | | |
    --     \__|  \__,_| |_.__/  |_.__/   \__, | (_) |_| |_|   \_/   |_| |_| |_| |_|
    --                                   |___/                                     
    {
        'nanozuki/tabby.nvim',
        event = 'VimEnter',
        init = function()
            vim.o.showtabline = 2
        end,
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            -- Using Bubbles config: https://github.com/nanozuki/tabby.nvim/discussions/51#discussioncomment-7260909
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
            tabline = {
            require('tabby').setup({
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
    --    _                   _   _                                      _             
    --    | |  _   _    __ _  | | (_)  _ __     ___       _ __   __   __ (_)  _ __ ___  
    --    | | | | | |  / _` | | | | | | '_ \   / _ \     | '_ \  \ \ / / | | | '_ ` _ \ 
    --    | | | |_| | | (_| | | | | | | | | | |  __/  _  | | | |  \ V /  | | | | | | | |
    --    |_|  \__,_|  \__,_| |_| |_| |_| |_|  \___| (_) |_| |_|   \_/   |_| |_| |_| |_|
    --                                                                                  
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
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

    --    _   _                  _                                        _             
    --    _ __ ___     ___     __| | (_)   ___    __ _  | |_    ___    _ __       _ __   __   __ (_)  _ __ ___  
    --   | '_ ` _ \   / _ \   / _` | | |  / __|  / _` | | __|  / _ \  | '__|     | '_ \  \ \ / / | | | '_ ` _ \ 
    --   | | | | | | | (_) | | (_| | | | | (__  | (_| | | |_  | (_) | | |     _  | | | |  \ V /  | | | | | | | |
    --   |_| |_| |_|  \___/   \__,_| |_|  \___|  \__,_|  \__|  \___/  |_|    (_) |_| |_|   \_/   |_| |_| |_| |_|
    --                                                                                                          
    --[[ Not going to activate this until I know it won't mess with themes
    {
        'mawkler/modicator.nvim',
        dependencies = 'mawkler/onedark.nvim', -- Add your colorscheme plugin here
        init = function()
          -- These are required for Modicator to work
          vim.o.cursorline = true
          vim.o.number = true
          vim.o.termguicolors = true
        end,
        opts = {
          -- Warn if any required option above is missing. May emit false positives
          -- if some other plugin modifies them, which in that case you can just
          -- ignore. Feel free to remove this line after you've gotten Modicator to
          -- work properly.
          show_warnings = true,
        }
      }
      ]]--
}