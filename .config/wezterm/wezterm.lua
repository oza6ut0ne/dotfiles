local wezterm = require 'wezterm'
local appearance = require 'appearance'
local binding = require 'binding'

local config = {}
config = wezterm.config_builder()

appearance.apply(config)
binding.apply(config)

local local_config_exists, local_config = pcall(require, 'local')
if local_config_exists then
  local_config.apply(config)
end

return config
