-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()
local act = wezterm.action

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.font = wezterm.font 'CaskaydiaCove Nerd Font'
-- config.font = wezterm.font 'CaskaydiaCove Nerd Font Mono'
config.font = wezterm.font 'JetBrains Mono'
-- config.font = wezterm.font 'DejaVuSansM Nerd Font'
--
--config.color_scheme = 'Batman'
config.color_scheme = 'Tokyo Night'

config.default_cursor_style = 'BlinkingBar'
-- config.animation_fps = 60
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

config.keys = {
  {
    key = "h",
    mods = "CTRL|SHIFT|ALT",
    action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
  },

  {
    key = "v",
    mods = "CTRL|SHIFT|ALT",
    action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
  },

  {
    key = "w",
    mods = "CTRL|SHIFT|ALT",
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },

  {
    key = 'LeftArrow',
    mods = 'CTRL|SHIFT',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'RightArrow',
    mods = 'CTRL|SHIFT',
    action = act.ActivatePaneDirection 'Right',
  },
  {
    key = 'UpArrow',
    mods = 'CTRL|SHIFT',
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'DownArrow',
    mods = 'CTRL|SHIFT',
    action = act.ActivatePaneDirection 'Down',
  },
}

config.window_close_confirmation = 'NeverPrompt'

wezterm.on('update-right-status', function(window, pane)
  -- "Wed Mar 3 08:14"
  -- local date = wezterm.strftime '%a %b %-d %H:%M'
  local time = wezterm.strftime '%H:%M'
--
  local bat = ''
  for _, b in ipairs(wezterm.battery_info()) do
    bat = '🔋' .. string.format('%.0f%%', b.state_of_charge * 100)
  end
--
  window:set_right_status(wezterm.format {
    { Text = bat .. '   ' .. time },
  })
end)

-- config.hide_tab_bar_if_only_one_tab = true

config.window_frame = {
  -- font = wezterm.font 'JetBrains Mono',
  -- font_size = 10,
  active_titlebar_bg = '#16161e',
}

config.colors = {
  tab_bar = {
    background = '#16161e',

    active_tab = {
      bg_color = '#1a1b26',
      fg_color = '#a9b1d6',
      -- intensity = 'Bold',
      -- underline = 'Single',
      -- strikethrough = true,
    },

    inactive_tab = {
      bg_color = '#16161e',
      fg_color = '#a9b1d6',
      -- intensity = 'Half',
    },

    -- inactive_tab_hover = {
    --   bg_color = '#16161e',
    --   fg_color = '#a9b1d6',
    --   italic = true,
    -- },

    new_tab = {
      bg_color = '#16161e',
      fg_color = '#a9b1d6',
    },
  },
}

config.window_background_opacity = 0.95
-- and finally, return the configuration to wezterm
return config
