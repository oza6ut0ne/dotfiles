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
      key = 's',
      mods = 'LEADER',
      action = act.ShowLauncherArgs { flags = 'WORKSPACES', title = 'Select workspace' },
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

return module
