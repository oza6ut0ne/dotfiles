local wezterm = require 'wezterm'

local module = {}

function module.apply(config)
  config.hide_tab_bar_if_only_one_tab = true
  config.adjust_window_size_when_changing_font_size = false
  config.scrollback_lines = 50000
  config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  }
  if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    config.enable_scroll_bar = true
  end

  config.window_background_opacity = 0.9
  config.color_scheme = 'Dracula (Official)'
  -- config.color_scheme = 'Everforest Dark Hard (Gogh)'
  -- config.color_scheme = 'Ubuntu'
  config.colors = {
      foreground = '#c6d3aa',
      -- foreground = '#94f13a',
  }

  config.font_size = 14
  config.line_height = 0.96
  config.font = wezterm.font_with_fallback({
    'UDEV Gothic 35',
    'Blobmoji',
    {
      family = 'JetBrains Mono',
      harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
    },
  })
end

return module
