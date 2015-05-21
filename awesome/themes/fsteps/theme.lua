--[[ -----------------------------------
   Mmodified default awesome theme --
--]] -----------------------------------

home_dir   = os.getenv("HOME")
theme_dir  = home_dir .. "/.config/awesome/themes/fsteps"

theme = {}

theme.font          = "tewi 8"

theme.bg_normal     = "#111416"
theme.bg_focus      = theme.bg_normal
theme.bg_urgent     = theme.bg_normal
theme.bg_minimize   = theme.bg_normal

theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#f0eef1"
theme.fg_focus      = "#777777"
theme.fg_urgent     = "#d99395"
theme.fg_minimize   =  theme.fg_focus

theme.border_width  = 2
theme.border_normal = "#111111"
theme.border_focus  = "#9cabc8"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty]
theme.taglist_fg_focus    = "#a6b3d2"
theme.taglist_fg_urgent   = theme.fg_urgent
theme.taglist_fg_occupied = theme.fg_minimize
theme.taglist_fg_empty    = theme.fg_normal

-- tasklist_[bg|fg]_[focus|urgent]
theme.tasklist_fg_focus  = theme.taglist_fg_focus
theme.tasklist_fg_urgent = theme.taglist_fg_urgent

-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
theme.tasklist_disable_icon = true
theme.tasklist_floating = ""
theme.tasklist_maximized_horizontal = ""
theme.tasklist_maximized_vertical   = ""

-- Display the taglist squares
-- theme.taglist_squares_sel   = theme_dir .. "/taglist/squarefw.png"
-- theme.taglist_squares_unsel = theme_dir .. "/taglist/squarew.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = 16
theme.menu_width  = 100
theme.menu_submenu_icon = theme_dir .. "/submenu.png"
theme.menu_border_width = theme.border_width
theme.menu_border_color = theme.taglist_fg_focus

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua

-- You can use your own layout icons like this:
theme.layout_fairh      = theme_dir .. "/layouts/fairh.png"
theme.layout_fairv      = theme_dir .. "/layouts/fairv.png"
theme.layout_floating   = theme_dir .. "/layouts/floating.png"
theme.layout_magnifier  = theme_dir .. "/layouts/magnifier.png"
theme.layout_tilebottom = theme_dir .. "/layouts/tilebottom.png"
theme.layout_tileleft   = theme_dir .. "/layouts/tileleft.png"
theme.layout_tile       = theme_dir .. "/layouts/tile.png"
theme.layout_tiletop    = theme_dir .. "/layouts/tiletop.png"
theme.layout_spiral     = theme_dir .. "/layouts/spiral.png"
theme.layout_dwindle    = theme_dir .. "/layouts/dwindle.png"

-- Icons
theme.arrow  = theme_dir .. "/icons/arrow.png"
theme.oarrow = theme_dir .. "/icons/oarrow.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
