local wezterm = require("wezterm")
local act = wezterm.action

local function key(k, a, m)
  return { key = k, mods = m or "LEADER", action = a }
end

local mappings = {
    leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
    keys = {
        -- Send C-a when pressing C-a twice
        key("a", act.SendKey { key = "a", mods = "CTRL" }, "LEADER|CTRL"),
        key("c", act.ActivateCopyMode),
        key("phys:Space", act.ActivateCommandPalette),

        -- Pane keybindings
        key("s", act.SplitVertical { domain = "CurrentPaneDomain" }),
        key("v", act.SplitHorizontal { domain = "CurrentPaneDomain" }),
        key("h", act.ActivatePaneDirection("Left")),
        key("j", act.ActivatePaneDirection("Down")),
        key("k", act.ActivatePaneDirection("Up")),
        key("l", act.ActivatePaneDirection("Right")),
        key("q", act.CloseCurrentPane { confirm = true }),
        key("z", act.TogglePaneZoomState),
        key("o", act.RotatePanes "Clockwise"),
        -- We can make separate keybindings for resizing panes
        -- But Wezterm offers custom "mode" in the name of "KeyTable"
        key("r", act.ActivateKeyTable { name = "resize_pane", one_shot = false }),

        -- Tab keybindings
        key("t", act.SpawnTab("CurrentPaneDomain")),
        key("[", act.ActivateTabRelative(-1)),
        key("]", act.ActivateTabRelative(1)),
        key("n", act.ShowTabNavigator),
        key(
          "e",
          act.PromptInputLine {
            description = wezterm.format {
              { Attribute = { Intensity = "Bold" } },
              { Foreground = { AnsiColor = "Fuchsia" } },
              { Text = "Renaming Tab Title...:" },
            },
            action = wezterm.action_callback(function(window, pane, line)
              if line then
                window:active_tab():set_title(line)
              end
            end)
          }
        ),
        -- Key table for moving tabs around
        key("m",act.ActivateKeyTable { name = "move_tab", one_shot = false }),
        -- Or shortcuts to move tab w/o move_tab table. SHIFT is for when caps lock is on
        key("{", act.MoveTabRelative(-1), "LEADER|SHIFT"),
        key("}", act.MoveTabRelative(1), "LEADER|SHIFT"),

        -- Lastly, workspace
        key("w", act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" }),
    },
    key_tables = {
        resize_pane = {
          { key = "h", action = act.AdjustPaneSize { "Left", 1 } },
          { key = "j", action = act.AdjustPaneSize { "Down", 1 } },
          { key = "k", action = act.AdjustPaneSize { "Up", 1 } },
          { key = "l", action = act.AdjustPaneSize { "Right", 1 } },
          { key = "Escape", action = "PopKeyTable" },
          { key = "Enter", action = "PopKeyTable" },
        },
        move_tab = {
          { key = "h", action = act.MoveTabRelative(-1) },
          { key = "j", action = act.MoveTabRelative(-1) },
          { key = "k", action = act.MoveTabRelative(1) },
          { key = "l", action = act.MoveTabRelative(1) },
          { key = "Escape", action = "PopKeyTable" },
          { key = "Enter", action = "PopKeyTable" },
        }
    }
}

-- I can use the tab navigator (LDR t), but I also want to quickly navigate tabs with index
for i = 1, 9 do
    table.insert(
        mappings.keys, 
        key(tostring(i), act.ActivateTab(i - 1))
    )
end

return mappings