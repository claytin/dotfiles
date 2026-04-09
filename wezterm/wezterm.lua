-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Fonts
config.font = wezterm.font_with_fallback {
   {
      family = 'JetBrains Mono', weight = 'Regular',
      harfbuzz_features = {
         'zero', 'cv04', 'cv11', 'cv12', 'cv17'
      }
   },

   {
      family = 'Fira Code', weight = 'Regular',
      harfbuzz_features = {
         'cv01', 'cv02', 'cv05', 'cv09', 'cv16', 'ss01', 'ss02', 'ss03',
         'ss05', 'ss06'
      }
   },

   { family = 'DejaVu Sans Mono', weight = 'Regular' },
   { family = 'MotoyaLMaru', weight = 'Regular' },
   { family = 'Noto Sans Mono CJK JP', weight = 'Regular' }
}

config.font_size = 10.5

-- Custom colors
-- TODO Should define variables for the colors
config.colors = {
   -- Overrides the cell background color when the current cell is occupied by
   -- the cursor and the cursor style is set to Block
   cursor_bg     = '#586e74',
   -- Overrides the text color when the current cell is occupied by the cursor
   cursor_fg     = '#eee8d5',
   -- Specifies the border color of the cursor
   cursor_border = '#586e74',

   -- Solarized-light colors for the tab bar
   tab_bar = {
	  background = '#eee8d5',

	  active_tab = {
		 bg_color = '#fdf6e3',
		 fg_color = '#586e74',

		 intensity = 'Bold',
	  },

	  inactive_tab = {
		 bg_color = '#073642',
		 fg_color = '#93a1a1',

		 italic = true,
	  },

	  inactive_tab_hover = {
		 bg_color = '#002b36',
		 fg_color = '#93a1a1',
	  },

	  new_tab = {
		 bg_color = '#073642',
		 fg_color = '#93a1a1',

		 italic = true,
	  },

	  new_tab_hover = {
		 bg_color = '#002b36',
		 fg_color = '#93a1a1',

		 intensity = 'Bold',
	  },
   }
}

-- Blinking block cursor
config.default_cursor_style = 'BlinkingBlock'
config.animation_fps = 60
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

config.hide_mouse_cursor_when_typing = true

-- Tab bar
config.hide_tab_bar_if_only_one_tab = true
-- the tab bar is rendered using a retro aesthetic using the main terminal font
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
-- tab max width is 16 by default, which is fine

-- Window
-- Remove title bar, but keep the ability to resize the window
config.window_decorations = 'RESIZE'
-- Geometry
config.initial_rows = 30
config.initial_cols = 120
-- Padding
config.window_padding = {
   left   = '10px',
   right  = '10px',
   top    = '12px',
   bottom = '8px',
}

-- and finally, return the configuration to wezterm
return config
