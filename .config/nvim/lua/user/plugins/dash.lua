return {

  opts = function()
    local logo = [[
[48;5;0m                                              [38;2;167;201;171m
       [38;2;31;107;152m███████████           [38;2;57;108;63m█████[38;2;167;201;171m      ██
      [38;2;34;115;163m███████████             [38;2;61;116;68m█████ 
      [38;2;36;122;174m███████[48;5;0m██[38;2;20;69;110m[38;2;122;187;225m███████ ███[38;2;65;124;72m████████ [38;2;152;192;157m███   ███████
     [38;2;38;130;184m█████████[38;2;132;191;226m███████[48;5;0m ████[38;2;69;132;76m████████ [38;2;160;196;164m█████ ██████████████
    [38;2;40;138;195m█████████[38;2;142;196;228m█████[48;5;0m[38;2;20;69;110m██[38;2;142;196;228m██████[38;2;73;140;81m███████ [38;2;167;201;171m█████ █████ ████ █████
  [38;2;43;145;206m███████████[38;2;151;200;229m█████████████████[38;2;77;147;86m██████ [38;2;175;205;179m█████ █████ ████ █████
 [38;2;45;153;217m██████  ███ [38;2;160;204;231m█████████████████ [38;2;81;155;90m████ [38;2;183;209;186m█████ █████ ████ ██████
 [38;2;20;69;110m██████   ██  ███████████████   [38;2;46;78;42m██ █████████████████
[48;2;20;20;40m [38;2;11;39;63m██████   ██  ███████████████   [38;2;25;42;23m██ █████████████████ [48;5;0m
  ]]

    logo = string.rep("\n", 8) .. logo .. "\n\n"

    local opts = {
      theme = "doom",
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      config = {
        header = vim.split(logo, "\n"),
        -- stylua: ignore
        center = {
          { action = LazyVim.telescope("files"),                                    desc = " Find File",       icon = " ", key = "f" },
          { action = "ene | startinsert",                                        desc = " New File",        icon = " ", key = "n" },
          { action = "Telescope oldfiles",                                       desc = " Recent Files",    icon = " ", key = "r" },
          { action = "Telescope live_grep",                                      desc = " Find Text",       icon = " ", key = "g" },
          { action = [[lua LazyVim.telescope.config_files()()]], desc = " Config",          icon = " ", key = "c" },
          { action = 'lua require("persistence").load()',                        desc = " Restore Session", icon = " ", key = "s" },
          { action = "LazyExtras",                                               desc = " Lazy Extras",     icon = " ", key = "x" },
          { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
          { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "DashboardLoaded",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    return opts
  end,
}
