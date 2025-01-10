local wezterm = require("wezterm")
local config = {}

config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.font = wezterm.font("Fira Code")
config.font_size = 14
config.color_scheme = "Vs Code Dark+ (Gogh)"
config.initial_rows = 35
config.initial_cols = 120

return config
