-- Place at $HOME/.config/wezterm/wezterm.lua
--   Windows -> C:\Users\{User}\.config\wezterm\wezterm.lua
--   macOS   -> ~/.config/wezterm/wezterm.lua

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local is_windows = wezterm.target_triple:find('windows') ~= nil

-- japanese text {{{1
--------------------------------------
-- Treat East Asian Ambiguous characters (○●■→※±×“ etc.) as two cells.
-- Three layers must agree on this width or columns drift and the display
-- breaks up:
--   1. terminal cell allocation -> this option
--   2. Neovim 'ambiwidth'       -> 'double' (config/display.lua)
--   3. font glyph advance       -> UDEV Gothic JPDOC
config.treat_east_asian_ambiguous_width_as_wide = true

-- Known issue: halfwidth katakana with a voicing mark (ｶﾞ) is counted as one
-- cell by Neovim 0.11+ but two cells here, so those lines drift.
-- See neovim/neovim#34733; unfixed. Only affects halfwidth katakana.

-- font {{{1
--------------------------------------
-- Bold/italic/bold-italic are resolved automatically from the same family.
config.font = wezterm.font_with_fallback {
  'UDEV Gothic JPDOC',
}
config.font_size = 12.0

-- Loosen the grid slightly. Both scale the computed cell and default to 1.0.
config.line_height = 1.1
config.cell_width = 1.05

-- window {{{1
--------------------------------------
config.initial_cols = 100
config.initial_rows = 30

-- The tab bar only appears once a second tab exists.
config.hide_tab_bar_if_only_one_tab = true

config.window_background_opacity = 0.92
config.window_padding = {
  left = 2,
  right = 2,
  top = 2,
  bottom = 2,
}

-- cursor and selection {{{1
--------------------------------------
config.default_cursor_style = 'SteadyBar'

-- copy to the clipboard as soon as a mouse selection is released
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.CompleteSelection 'ClipboardAndPrimarySelection',
  },
}

-- shell {{{1
--------------------------------------
if is_windows then
  -- Open into the WSL distro. The login shell is already set with chsh,
  -- so default_prog is left unset.
  config.wsl_domains = wezterm.default_wsl_domains()
  config.default_domain = 'WSL:Ubuntu'
else
  config.default_prog = { '/usr/local/bin/fish', '-l' }
end

-- colors {{{1
--------------------------------------
config.colors = {
  foreground = '#C5D4DD',
  background = '#0C1C25',

  cursor_bg = '#C5D4DD',
  cursor_fg = '#0C1C25',
  cursor_border = '#C5D4DD',

  ansi = {
    '#3C4C55', -- black
    '#DF8C8C', -- red
    '#A8CE93', -- green
    '#DADA93', -- yellow
    '#83AFE5', -- blue
    '#9A93E1', -- magenta
    '#7FC1CA', -- cyan
    '#C5D4DD', -- white
  },
  brights = {
    '#899BA6', -- black
    '#F2C38F', -- red
    '#A8CE93', -- green
    '#DADA93', -- yellow
    '#83AFE5', -- blue
    '#D18EC2', -- magenta
    '#7FC1CA', -- cyan
    '#E6EEF3', -- white
  },
}

-- machine-local overrides {{{1
--------------------------------------
-- Display-dependent values (font_size, line_height, cell_width, initial_cols,
-- initial_rows) live in an untracked wezterm_local.lua next to this file, which
-- returns a table of config keys to override:
--
--   return {
--     font_size = 14.0,
--     initial_cols = 120,
--     initial_rows = 60,
--   }
--
-- Absent file -> no-op. The load itself is unguarded so a syntax error in the
-- local file surfaces in the config-error overlay instead of being swallowed.
local local_config = wezterm.config_dir .. '/wezterm_local.lua'
local f = io.open(local_config, 'r')
if f then
  f:close()
  for k, v in pairs(dofile(local_config)) do
    config[k] = v
  end
end

return config

-- vim: set foldmethod=marker:
