local wezterm = require 'wezterm'
local helpers = require 'helpers'
local act = wezterm.action

local module = {}

function module.apply(config)
  config.leader = { key = 'B', mods = 'CTRL', timeout_milliseconds = 1500 }
  if config.keys == nil then
    config.keys = {}
  end

  helpers.append_to_table(config.keys, {
    {
      key = 'B',
      mods = 'LEADER|CTRL',
      action = wezterm.action.SendKey { key = 'B', mods = 'CTRL' },
    },
    {
      key = '%',
      mods = 'LEADER|SHIFT',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = '%',
      mods = 'LEADER|SHIFT|CTRL',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = '"',
      mods = 'LEADER|SHIFT',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = '"',
      mods = 'LEADER|SHIFT|CTRL',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      mods = 'LEADER',
      key = 't',
      action = wezterm.action { EmitEvent = "increase-opacity" },
    },
    {
      mods = 'LEADER',
      key = 'T',
      action = wezterm.action { EmitEvent = "decrease-opacity" },
    },
    {
      mods = 'LEADER|CTRL',
      key = 'T',
      action = wezterm.action { EmitEvent = "decrease-opacity" },
    },
    {
      key = 's',
      mods = 'LEADER',
      action = act.ShowLauncherArgs { flags = 'WORKSPACES', title = 'Select workspace' },
    },
    {
      key = 'C',
      mods = 'LEADER|SHIFT',
      action = act.SwitchToWorkspace { name = tostring(#wezterm.mux.get_workspace_names()) },
    },
    {
      key = 'C',
      mods = 'LEADER|SHIFT|CTRL',
      action = act.SwitchToWorkspace { name = tostring(#wezterm.mux.get_workspace_names()) },
    },
    {
      key = 'N',
      mods = 'LEADER|SHIFT',
      action = act.SwitchWorkspaceRelative(1),
    },
    {
      key = 'N',
      mods = 'LEADER|SHIFT|CTRL',
      action = act.SwitchWorkspaceRelative(1),
    },
    {
      key = 'P',
      mods = 'LEADER|SHIFT',
      action = act.SwitchWorkspaceRelative(-1),
    },
    {
      key = 'P',
      mods = 'LEADER|SHIFT|CTRL',
      action = act.SwitchWorkspaceRelative(-1),
    },
    {
      mods = 'LEADER|SHIFT',
      key = '$',
      action = act.PromptInputLine {
        description = '(wezterm) Set workspace title:',
        action = wezterm.action_callback(function(win, pane, line)
          if line then
            wezterm.mux.rename_workspace(
              wezterm.mux.get_active_workspace(),
              line
            )
          end
        end),
      },
    },
    {
      mods = 'LEADER|SHIFT|CTRL',
      key = '$',
      action = act.PromptInputLine {
        description = '(wezterm) Set workspace title:',
        action = wezterm.action_callback(function(win, pane, line)
          if line then
            wezterm.mux.rename_workspace(
              wezterm.mux.get_active_workspace(),
              line
            )
          end
        end),
      },
    },
    {
      key = 'UpArrow',
      mods = 'SHIFT',
      action = act.ScrollToPrompt(-1),
    },
    {
      key = 'DownArrow',
      mods = 'SHIFT',
      action = act.ScrollToPrompt(1),
    },
    {
      key = 'l',
      mods = 'ALT',
      action = act.ShowLauncher,
    },
    {
      key = 'Q',
      mods = 'SHIFT|CTRL',
      action = act.QuickSelect,
    },
  })
end

wezterm.on("decrease-opacity", function(window)
  local overrides = window:get_config_overrides() or {}
  if not overrides.window_background_opacity then
    overrides.window_background_opacity = 0.9
  end
  overrides.window_background_opacity = overrides.window_background_opacity - 0.1
  if overrides.window_background_opacity < 0.1 then
    overrides.window_background_opacity = 0.1
  end
  window:set_config_overrides(overrides)
end)

wezterm.on("increase-opacity", function(window)
  local overrides = window:get_config_overrides() or {}
  if not overrides.window_background_opacity then
    overrides.window_background_opacity = 1.0
  end
  overrides.window_background_opacity = overrides.window_background_opacity + 0.1
  if overrides.window_background_opacity > 1.0 then
    overrides.window_background_opacity = 1.0
  end
  window:set_config_overrides(overrides)
end)

return module
