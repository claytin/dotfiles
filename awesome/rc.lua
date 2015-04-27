-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")

-- Status widgets library
local vicious = require("vicious")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
     naughty.notify({
          preset = naughty.config.presets.critical,
          title = "Oops, there were errors during startup!",
          text = awesome.startup_errors
     })
end

-- Handle runtime errors after startup
do
     local in_error = false
     awesome.connect_signal("debug::error", function (err)
          -- Make sure we don't go into an endless error loop
          if in_error then return end
          in_error = true

          naughty.notify({
               preset = naughty.config.presets.critical,
               title = "Oops, an error happened!",
               text = err
          })

          in_error = false
     end)
end
-- }}}

-- {{{ Variable definitions
local confd = awful.util.getdir("config")
local homed = os.getenv("HOME")

local exec  = awful.util.spawn
local sexec = awful.util.spawn_with_shell

-- Themes define colours, icons, font and wallpapers
beautiful.init(confd .. "/themes/fsteps/theme.lua")

-- This is used later as the default terminal and editor to run
local terminal = "termite"
local editor = os.getenv("EDITOR") or "vim"

-- keys
alt  = "Mod1"
shft = "Shift"
ctrl = "Control"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts = {
     awful.layout.suit.floating,
     awful.layout.suit.tile,
     awful.layout.suit.tile.left,
     awful.layout.suit.tile.bottom,
     awful.layout.suit.tile.top,
     awful.layout.suit.fair,
     awful.layout.suit.fair.horizontal,
     awful.layout.suit.spiral,
     awful.layout.suit.spiral.dwindle,
     awful.layout.suit.magnifier
}
-- }}}

-- Wallpaper
sexec("sh " .. homed .. "/.fehbg &")

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
     -- Each screen has its own tag table.
     tags[s] = awful.tag({
          "www",
          "dev",
          "edit",
          "term",
          "mmid",
          "misc",
          "void"
     }, s, layouts[1])
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
     { "manual", terminal .. ' -e "man awesome"' },
     { "config", terminal .. ' -e "' .. editor .. " " .. awesome.conffile .. '"' },
     { "theme", terminal .. ' -e "' .. editor .. " " .. confd .. '/themes/fsteps/theme.lua"' },
     { "restart", awesome.restart }
}

mymainmenu = awful.menu({
     items = {
          { "awesome", myawesomemenu },
          { "quit", awesome.quit }
     }
})

-- Menubar configuration
-- Set the terminal for applications that require it
menubar.utils.terminal = terminal
-- }}}

-- {{{ Wibox
-- :build
local icons = {}
icons.arrow  = wibox.widget.imagebox(beautiful.arrow) -- will only be used later
icons.oarrow = wibox.widget.imagebox(beautiful.oarrow)

dtw = wibox.widget.textbox() -- date and time widget
vicious.register(dtw, vicious.widgets.date, " <span color='#a6b3d2'>dt</span>"
     .. " %a %d %b %H:%M ")

memw = wibox.widget.textbox() -- memory widget
vicious.register(memw, vicious.widgets.mem, " <span color='#a6b3d2'>mem</span>"
     .. " $2MB ")

cpuw = wibox.widget.textbox() -- cpu usage widget
vicious.register(cpuw, vicious.widgets.cpu, " <span color='#a6b3d2'>cpu</span>"
     .. " <span color='#777777'>#1</span> $1%"
     .. " <span color='#777777'>#2</span> $2% ")

thrmw = wibox.widget.textbox() -- cpu temperature widget
vicious.register(thrmw, vicious.widgets.thermal,
     " <span color='#a6b3d2'>temp</span>" .. " $1 °C ", 30, "thermal_zone0")

-- Create a wibox for each screen and add it
mywibox     = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist   = {}

mytaglist.buttons = awful.util.table.join(
     awful.button({ }, 1, awful.tag.viewonly),
     awful.button({ ctrl }, 1, awful.client.movetotag),
     awful.button({ }, 3, awful.tag.viewtoggle),
     awful.button({ ctrl }, 3, awful.client.toggletag)
)

mytasklist = {}
mytasklist.buttons = awful.util.table.join(
     awful.button({ }, 1, function (c)
          if c == client.focus then
               c.minimized = true
          else
               -- Without this, the following
               -- :isvisible() makes no sense
               c.minimized = false
               if not c:isvisible() then
                    awful.tag.viewonly(c:tags()[1])
               end
               -- This will also un-minimize
               -- the client, if needed
               client.focus = c
               c:raise()
          end
     end),

     awful.button({ }, 3, function ()
          if instance then
               instance:hide()
               instance = nil
          else
               instance = awful.menu.clients({
                    theme = { width = 250 }
               })
          end
     end)
)

for s = 1, screen.count() do
     -- Create a promptbox for each screen
     mypromptbox[s] = awful.widget.prompt()
     -- Create an imagebox widget which will contains an icon indicating which layout we're using.
     -- We need one layoutbox per screen.
     mylayoutbox[s] = awful.widget.layoutbox(s)
     mylayoutbox[s]:buttons(awful.util.table.join(
          awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
          awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end)
     ))
     -- Create a taglist widget
     mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

     -- Create a tasklist widget
     mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

     -- Create the wibox
     mywibox[s] = awful.wibox({ position = "top", screen = s, height = 18 })

     -- Widgets that are aligned to the left
     local left_layout = wibox.layout.fixed.horizontal()
     left_layout:add(mytaglist[s])
     left_layout:add(wibox.widget.textbox(" "))
     left_layout:add(icons.oarrow)
     left_layout:add(wibox.widget.textbox(" "))
     left_layout:add(mylayoutbox[s])
     left_layout:add(wibox.widget.textbox(" "))
     left_layout:add(icons.oarrow)
     left_layout:add(wibox.widget.textbox(" "))
     left_layout:add(mypromptbox[s])

     -- Widgets that are aligned to the right
     local right_layout = wibox.layout.fixed.horizontal()
     if s == 1 then right_layout:add(wibox.widget.systray()) end
     right_layout:add(icons.arrow)
     right_layout:add(thrmw)
     right_layout:add(icons.arrow)
     right_layout:add(cpuw)
     right_layout:add(icons.arrow)
     right_layout:add(memw)
     right_layout:add(icons.arrow)
     right_layout:add(dtw)

     -- Now bring it all together (with the tasklist in the middle)
     local layout = wibox.layout.align.horizontal()
     layout:set_left(left_layout)
     layout:set_middle(mytasklist[s])
     layout:set_right(right_layout)

     mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
     awful.button({ }, 3, function () mymainmenu:toggle() end)
))
-- }}}

-- {{{ Key bindings
-- ref:kb
globalkeys = awful.util.table.join(
     -- "walks" trough the tags
     awful.key({ ctrl, alt }, "Right",  awful.tag.viewnext),
     awful.key({ ctrl, alt }, "Left",   awful.tag.viewprev),

     awful.key({ alt }, "j", function ()
          awful.client.focus.byidx(1)
          if client.focus then client.focus:raise() end
     end),

     awful.key({ alt }, "k", function ()
          awful.client.focus.byidx(-1)
          if client.focus then client.focus:raise() end
     end),

     awful.key({ alt }, "u", awful.client.urgent.jumpto),

     awful.key({ alt, }, "Tab", function ()
          awful.client.focus.history.previous()
          if client.focus then client.focus:raise() end
     end),

     -- Layout manipulation
     -- what it realy does is move clients around the layout
     awful.key({ shft, alt }, "j", function () awful.client.swap.byidx(  1) end),
     awful.key({ shft, alt }, "k", function () awful.client.swap.byidx( -1) end),

     awful.key({ alt, }, "F1", function () mymainmenu:show() end),

     -- Standard program
     awful.key({ ctrl, alt }, "t", function () exec(terminal) end),
     awful.key({ ctrl, alt }, "e", function () exec("gvim") end),
     awful.key({ ctrl, alt }, "f", function () exec("pcmanfm") end),

     awful.key({ ctrl, alt }, "h", function () exec(terminal .. " -e htop") end),
     awful.key({ ctrl, alt }, "a", function () exec(terminal .. " -e alsamixer") end),

     awful.key({ ctrl, alt }, "r", awesome.restart),
     awful.key({ ctrl, alt }, "x", awesome.quit),

     awful.key({ shft, alt }, "Right", function () awful.tag.incmwfact( 0.05)   end),
     awful.key({ shft, alt }, "Left",  function () awful.tag.incmwfact(-0.05)   end),
     awful.key({ shft, alt }, "Down",  function () awful.client.incwfact( 0.05) end),
     awful.key({ shft, alt }, "Up",    function () awful.client.incwfact(-0.05) end),

     awful.key({ ctrl, alt }, "semicolon", function () awful.layout.inc(layouts, 1) end),
     awful.key({ ctrl, alt }, "period", function () awful.layout.inc(layouts, -1) end),

     awful.key({ alt, "space" }, "b", awful.client.restore), -- leave it here

     -- Prompt
     awful.key({ alt }, "F2", function () mypromptbox[mouse.screen]:run() end)
     -- awful.key({ alt }, "F2", function () exec("dmenu_run") end)
)

clientkeys = awful.util.table.join(
     awful.key({ ctrl, alt }, "q", function (c) c:kill() end),

     awful.key({ shft, alt }, "f", function (c) c.fullscreen = not c.fullscreen end),
     awful.key({ shft, alt }, "Return", awful.client.floating.toggle),

     awful.key({ alt, "space" }, "n", function (c)
          -- The client currently has the input focus, so it cannot be
          -- minimized, since minimized clients can't have the focus.
          c.minimized = true
     end),
     awful.key({ alt, "space" }, "m", function (c)
          c.maximized_horizontal = not c.maximized_horizontal
          c.maximized_vertical   = not c.maximized_vertical
     end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
     globalkeys = awful.util.table.join(globalkeys,
          -- View tag only.
          awful.key({ alt }, "#" .. i + 9, function ()
               local screen = mouse.screen
               local tag = awful.tag.gettags(screen)[i]
               if tag then
                    awful.tag.viewonly(tag)
               end
          end),
          -- Toggle tag.
          awful.key({ ctrl }, "#" .. i + 9, function ()
               local screen = mouse.screen
               local tag = awful.tag.gettags(screen)[i]
               if tag then
                    awful.tag.viewtoggle(tag)
               end
          end),
          -- Move client to tag.
          awful.key({ shft, alt }, "#" .. i + 9, function ()
               if client.focus then
                    local tag = awful.tag.gettags(client.focus.screen)[i]
                    if tag then
                         awful.client.movetotag(tag)
                    end
               end
          end)
     )
end

clientbuttons = awful.util.table.join(
     awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
     awful.button({ alt }, 1, awful.mouse.client.move),
     awful.button({ alt }, 3, awful.mouse.client.resize)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- ref:rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
     { rule = { }, -- All clients will match this rule.
          properties = {
               size_hints_honor     = false, -- !
               border_width         = beautiful.border_width,
               border_color         = beautiful.border_normal,
               focus                = awful.client.focus.filter,
               raise                = true,
               keys                 = clientkeys,
               maximized_vertical   = false, -- !
               maximized_horizontal = false, -- !
               buttons              = clientbuttons
          }
     },

     { rule = { class = "pcmanfm" },
          properties = { floating = true }
     },

     { rule = { class = "MPlayer" },
          properties = { floating = true }
     },

     { rule = { class = "gimp" },
          properties = { floating = true }
     },

     -- Set luakit to always open on 'www' of screen 1, maximized.
     { rule = { class = "luakit" },
          properties = {
               tag = tags[1][1],
               maximized_horizontal = true,
               maximized_vertical   = true
          }
     },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
     -- Enable sloppy focus
     c:connect_signal("mouse::enter", function(c)
          if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
             and awful.client.focus.filter(c) then
               client.focus = c
          end
     end)

     if not startup then
          -- Set the windows at the slave,
          -- i.e. put it at the end of others instead of setting it master.
          -- awful.client.setslave(c)

          -- Put windows in a smart way, only if they does not set an initial position.
          if not c.size_hints.user_position and not c.size_hints.program_position then
               awful.placement.no_overlap(c)
               awful.placement.no_offscreen(c)
          end
     end

     local titlebars_enabled = false
     if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
          -- buttons for the titlebar
          -- idented
          local buttons = awful.util.table.join(
               awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
               end),
               awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
               end)
          )

          -- Widgets that are aligned to the left
          local left_layout = wibox.layout.fixed.horizontal()
          left_layout:add(awful.titlebar.widget.iconwidget(c))
          left_layout:buttons(buttons)

          -- Widgets that are aligned to the right
          local right_layout = wibox.layout.fixed.horizontal()
          right_layout:add(awful.titlebar.widget.floatingbutton(c))
          right_layout:add(awful.titlebar.widget.maximizedbutton(c))
          right_layout:add(awful.titlebar.widget.stickybutton(c))
          right_layout:add(awful.titlebar.widget.ontopbutton(c))
          right_layout:add(awful.titlebar.widget.closebutton(c))

          -- The title goes in the middle
          local middle_layout = wibox.layout.flex.horizontal()
          local title = awful.titlebar.widget.titlewidget(c)
          title:set_align("center")
          middle_layout:add(title)
          middle_layout:buttons(buttons)

          -- Now bring it all together
          local layout = wibox.layout.align.horizontal()
          layout:set_left(left_layout)
          layout:set_right(right_layout)
          layout:set_middle(middle_layout)

          awful.titlebar(c):set_widget(layout)
     end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
