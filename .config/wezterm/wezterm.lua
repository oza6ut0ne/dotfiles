local wezterm = require 'wezterm'
local appearance = require 'appearance'
local binding = require 'binding'
local domain = require 'domain'

local config = {}
config = wezterm.config_builder()

appearance.apply(config)
binding.apply(config)
domain.apply(config)

local local_config_ok, local_config = pcall(require, 'local')
if local_config_ok then
  local_config.apply(config)
end

return config
