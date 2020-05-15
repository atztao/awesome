-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local vicious = require("vicious")
local xrandr = require("xrandr")

local cpu_widget = require("cpu-widget")

local markup = require("lain.util.markup")

-- Load Debian menu entries
-- require("debian.menu")
-- local battery_widget = require("awesome-wm-widgets.battery-widget.battery")
-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({ preset = naughty.config.presets.critical,
                   title = "Oops, there were errors during startup!",
                   text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function (err)
                           -- Make sure we don't go into an endless error loop
                           if in_error then return end
                           in_error = true

                           naughty.notify({ preset = naughty.config.presets.critical,
                                            title = "Oops, an error happened!",
                                            text = tostring(err) })
                           in_error = false
  end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(awful.util.get_themes_dir() .. "default/theme.lua")
-- theme.wallpaper = "/home/zhangtao/.config/awesome/default/background.png"
beautiful.init("/home/zhangtao/.config/awesome/default/theme.lua")



-- This is used later as the default terminal and editor to run.
terminal = "konsole"
-- terminal = "xterm"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 :height 80is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  -- awful.layout.suit.floating,
  awful.layout.suit.tile,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  -- awful.layout.suit.spiral,
  -- awful.layout.suit.spiral.dwindle,
  -- awful.layout.suit.max,
  -- awful.layout.suit.max.fullscreen,
  -- awful.layout.suit.magnifier,
  -- awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
  local instance = nil

  return function ()
    if instance and instance.wibox.visible then
      instance:hide()
      instance = nil
    else
      instance = awful.menu.clients({ theme = { width = 250 } })
    end
  end
end
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
  { "Hotkeys", function() return false, hotkeys_popup.show_help end},
  --   { "manual", terminal .. " -e man awesome" },
  --   { "edit config", editor_cmd .. " " .. awesome.conffile },
  { "Themes", "systemsettings5"},
  { "Display", "arandr"},
  { "Restart", awesome.restart },
  { "Quit", function() awesome.quit() end}
}


-- myawesomemenu = {
-- --   { "Manual", terminal .. " -e man awesome" },
-- --   { "Config", editor_cmd .. " " .. awesome.conffile },
--    { "主题", "lxappearance" },
--    { "重载", awesome.restart },
--    { "退出", awesome.quit }
-- }


myappinstalled = {
  { "浏览", "google-chrome-stable --force-device-scale-factor=1.0 %U --ppapi-flash-path=/home/zhangtao/.config/google-chrome/PepperFlash/libpepflashplayer.so" },
  { "播放", "audacious" },
  { "编辑", "emacs" },
  { "文件", "dolphin" },
  { "阅读", "okular" },
  { "计算", "Mathematica" },
  -- { "梯子", "./Dropbox/Apps/Shadowsocks-Qt5-3.0.1-x86_64.AppImage"},
  { "虚拟", "sh ~/.config/awesome/script/win10.sh"}

}

mymainmenu = awful.menu({ items = { { "系统", myawesomemenu, beautiful.awesome_icon },
                            --                                    { "Debian", debian.menu.Debian_menu.Debian },
                            --                                    { "open terminal", terminal },
                            { "软件", myappinstalled },

}
                       })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
-- mytextclock = wibox.widget.textclock("%a %b %d, %H:%M",10)
mytextclock = wibox.widget.textclock(" %H:%M",10)
-- mytextclock = wibox.widget.textclock(markup(white, "%H:%M "),10)

------------------------------
-- Initialize widget
memwidget = wibox.widget.textbox()
-- Register widget
-- vicious.register(memwidget, vicious.widgets.mem, " M: $1% ", 13)

-- Initialize widget
cpuwidget = wibox.widget.textbox()
-- Register widget
-- vicious.register(cpuwidget, vicious.widgets.cpu, "C: $1% ")

--batterywidget = wibox.widget.textbox()

batwidget = wibox.widget.textbox()
vicious.register(batwidget, vicious.widgets.bat, " $2% ", 30, "BAT0")
bat_icon = wibox.widget.imagebox()
bat_icon:set_image(os.getenv("HOME") .. "/.config/awesome/battery.png")

------------------------------

-- Separator icon
-- separator = widget({ type = "textbox", align = "right"})
-- separator.text = " "
--


-- Create a wibox for each screen and add it
local taglist_buttons = awful.util.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
      if client.focus then
        client.focus:move_to_tag(t)
      end
  end),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
      if client.focus then
        client.focus:toggle_tag(t)
      end
  end),
  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = awful.util.table.join(
  awful.button({ }, 1, function (c)
      if c == client.focus then
        c.minimized = true
      else
        -- Without this, the following
        -- :isvisible() makes no sense
        c.minimized = false
        if not c:isvisible() and c.first_tag then
          c.first_tag:view_only()
        end
        -- This will also un-minimize
        -- the client, if needed
        client.focus = c
        c:raise()
      end
  end),
  awful.button({ }, 3, client_menu_toggle_fn()),
  awful.button({ }, 4, function ()
      awful.client.focus.byidx(1)
  end),
  awful.button({ }, 5, function ()
      awful.client.focus.byidx(-1)
end))

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1:Term", "2:Net", "3:Music", "4:Mail" }, s, awful.layout.layouts[1])
    -- awful.tag({ "1:Net", "2:Term", "3:Music", "4:Code" }, s,  awful.layout.suit.floating)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                            awful.button({ }, 1, function () awful.layout.inc( 1) end),
                            awful.button({ }, 3, function () awful.layout.inc(-1) end),
                            awful.button({ }, 4, function () awful.layout.inc( 1) end),
                            awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s,fg = beautiful.fg_normal, height = 18, bg = beautiful.bg_normal, border_width = beautiful.border_width, border_color = beautiful.border_normal})

    -- Add widgets to the wibox
    s.mywibox:setup {
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        s.mylayoutbox,
        -- mylauncher,
        s.mytaglist,
        s.mypromptbox,
      },
      s.mytasklist, -- Middle widget
      { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        --    mykeyboardlayout,
        cpuwidget,
        memwidget,
        --batterywidget,

        cpu_widget({
            width = 72,
            step_width = 2,
            step_spacing = 0,
            color = '#434c5e'
        }),
        wibox.widget.systray(),
        
        -- space,
        -- separator,
        -- bat_icon,
        -- batwidget,
        mytextclock,
        -- s.mylayoutbox,
      },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
               awful.button({ }, 3, function () mymainmenu:toggle() end),
               awful.button({ }, 4, awful.tag.viewnext),
               awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Global Keybindings With yourself
globalkeys = awful.util.table.join(

  -------------------------------------
  -- Key Yourself
  awful.key({}, "Print", function () awful.util.spawn("scrot -s -e 'mv $f ~/Dropbox/screenshots  2>/dev/null'") end), -- $ scrot -s -e 'mv $f ~/Dropbox/screenshots  2>/dev/null'| print $f -
  awful.key({}, "XF86AudioLowerVolume", function () awful.util.spawn("amixer set Master 5%-", false) end),
  awful.key({}, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer set Master 5%+", false) end),
  awful.key({}, "XF86AudioMute", function () awful.util.spawn("amixer set Master 1+ toggle", false) end),


  awful.key({  }, "#232", function () awful.util.spawn("xbacklight -dec 10") end),
  awful.key({  }, "#233", function () awful.util.spawn("xbacklight -inc 10") end),
  -- awful.key({modkey}, ";", function() xrandr.xrandr() end),

  awful.key({ modkey, }, "g", function () awful.util.spawn("google-chrome-stable --force-device-scale-factor=1.12 %U --ppapi-flash-path=/home/zhangtao/.config/google-chrome/PepperFlash/libpepflashplayer.so") end),
  awful.key({ modkey, }, "e", function () awful.util.spawn("emacs") end),
  awful.key({ modkey, }, "v", function () awful.util.spawn("konsole -e vim") end),
  awful.key({ modkey, }, "i", function () awful.util.spawn("firefox") end),
  awful.key({ modkey, }, "d", function () awful.util.spawn("nautilus") end),
  awful.key({ modkey, }, "a", function () awful.util.spawn("netease-cloud-music") end),
  --    awful.key({ modkey, "Control" }, "t", function () awful.util.spawn("thunar") end),
  awful.key({ "Mod1", "Control" }, "l", function () awful.util.spawn("i3lock") end),

  --------------------------------------


  awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
    {description="show help", group="awesome"}),
  awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
    {description = "view previous", group = "tag"}),
  awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
    {description = "view next", group = "tag"}),
  awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
    {description = "go back", group = "tag"}),

  awful.key({ modkey,           }, "j",
    function ()
      awful.client.focus.byidx( 1)
    end,
    {description = "focus next by index", group = "client"}
  ),
  awful.key({ modkey,           }, "k",
    function ()
      awful.client.focus.byidx(-1)
    end,
    {description = "focus previous by index", group = "client"}
  ),
  awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
    {description = "show main menu", group = "awesome"}),

  -- Layout manipulation
  awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
    {description = "swap with next client by index", group = "client"}),
  awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
    {description = "swap with previous client by index", group = "client"}),
  awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
    {description = "focus the next screen", group = "screen"}),
  awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
    {description = "focus the previous screen", group = "screen"}),
  awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
    {description = "jump to urgent client", group = "client"}),
  awful.key({ modkey,           }, "Tab",
    function ()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end,
    {description = "go back", group = "client"}),

  -- Standard program
  awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
    {description = "open a terminal", group = "launcher"}),
  awful.key({ modkey, "Control" }, "r", awesome.restart,
    {description = "reload awesome", group = "awesome"}),
  awful.key({ modkey, "Shift"   }, "q", awesome.quit,
    {description = "quit awesome", group = "awesome"}),

  awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
    {description = "increase master width factor", group = "layout"}),
  awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
    {description = "decrease master width factor", group = "layout"}),
  awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
    {description = "increase the number of master clients", group = "layout"}),
  awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
    {description = "decrease the number of master clients", group = "layout"}),
  awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
    {description = "increase the number of columns", group = "layout"}),
  awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
    {description = "decrease the number of columns", group = "layout"}),
  awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
    {description = "select next", group = "layout"}),
  awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
    {description = "select previous", group = "layout"}),

  awful.key({ modkey, "Shift" }, "n",
    function ()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        client.focus = c
        c:raise()
      end
    end,
    {description = "restore minimized", group = "client"}),

  -- Prompt
  -- awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
  --   {description = "run prompt", group = "launcher"}),

  awful.key({ modkey }, "x",
    function ()
      awful.prompt.run {
        prompt       = "Run Lua code: ",
        textbox      = awful.screen.focused().mypromptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval"
      }
    end,
    {description = "lua execute prompt", group = "awesome"}),
  -- Menubar
  awful.key({ modkey }, "p", function() menubar.show() end,
    {description = "show the menubar", group = "launcher"})
)

clientkeys = awful.util.table.join(
  awful.key({ modkey,           }, "f",
    function (c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    {description = "toggle fullscreen", group = "client"}),
  awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
    {description = "close", group = "client"}),
  awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
    {description = "toggle floating", group = "client"}),
  awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
    {description = "move to master", group = "client"}),
  awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
    {description = "move to screen", group = "client"}),
  awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
    {description = "toggle keep on top", group = "client"}),
  awful.key({ modkey,           }, "n",
    function (c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end ,
    {description = "minimize", group = "client"}),
  awful.key({ modkey,           }, "m",
    function (c)
      c.maximized = not c.maximized
      c:raise()
    end ,
    {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = awful.util.table.join(globalkeys,
                                     -- View tag only.
                                     awful.key({ modkey }, "#" .. i + 9,
                                       function ()
                                         local screen = awful.screen.focused()
                                         local tag = screen.tags[i]
                                         if tag then
                                           tag:view_only()
                                         end
                                       end,
                                       {description = "view tag #"..i, group = "tag"}),
                                     -- Toggle tag display.
                                     awful.key({ modkey, "Control" }, "#" .. i + 9,
                                       function ()
                                         local screen = awful.screen.focused()
                                         local tag = screen.tags[i]
                                         if tag then
                                           awful.tag.viewtoggle(tag)
                                         end
                                       end,
                                       {description = "toggle tag #" .. i, group = "tag"}),
                                     -- Move client to tag.
                                     awful.key({ modkey, "Shift" }, "#" .. i + 9,
                                       function ()
                                         if client.focus then
                                           local tag = client.focus.screen.tags[i]
                                           if tag then
                                             client.focus:move_to_tag(tag)
                                           end
                                         end
                                       end,
                                       {description = "move focused client to tag #"..i, group = "tag"}),
                                     -- Toggle tag on focused client.
                                     awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                                       function ()
                                         if client.focus then
                                           local tag = client.focus.screen.tags[i]
                                           if tag then
                                             client.focus:toggle_tag(tag)
                                           end
                                         end
                                       end,
                                       {description = "toggle focused client on tag #" .. i, group = "tag"})
  )
end

clientbuttons = awful.util.table.join(
  awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
  awful.button({ modkey }, 1, awful.mouse.client.move),
  awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  { rule = { },
    properties = { border_width = beautiful.border_width,
                   border_color = beautiful.border_normal,
                   focus = awful.client.focus.filter,
                   raise = true,
                   keys = clientkeys,
                   buttons = clientbuttons,
                   screen = awful.screen.preferred,
                   placement = awful.placement.no_overlap+awful.placement.no_offscreen
    }
  },

  -- Floating clients.
  { rule_any = {
      instance = {
        "DTA",  -- Firefox addon DownThemAll.
        "copyq",  -- Includes session name in class.
      },
      class = {
        "Arandr",
        "Gpick",
        "Kruler",
        "MessageWin",  -- kalarm.
        "Sxiv",
        "Wpa_gui",
        "pinentry",
        "veromix",
        "xtightvncviewer"},

      name = {
        "Event Tester",  -- xev.
      },
      role = {
        "AlarmWindow",  -- Thunderbird's calendar.
        "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
      }
  }, properties = { floating = true }},

  -- Add titlebars to normal clients and dialogs
  { rule_any = {type = { "normal", "dialog" }
               }, properties = { titlebars_enabled = false }
  },

  -- Set Firefox to always map on the tag named "2" on screen 1.
  -- { rule = { class = "Firefox" },
  --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
                        -- Set the windows at the slave,
                        -- i.e. put it at the end of others instead of setting it master.
                        -- if not awesome.startup then awful.client.setslave(c) end

                        if awesome.startup and
                          not c.size_hints.user_position
                        and not c.size_hints.program_position then
                          -- Prevent clients from being unreachable after screen count changes.
                          awful.placement.no_offscreen(c)
                        end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
                        -- buttons for the titlebar
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

                        awful.titlebar(c) : setup {
                          { -- Left
                            awful.titlebar.widget.iconwidget(c),
                            buttons = buttons,
                            layout  = wibox.layout.fixed.horizontal
                          },
                          { -- Middle
                            { -- Title
                              align  = "center",
                              widget = awful.titlebar.widget.titlewidget(c)
                            },
                            buttons = buttons,
                            layout  = wibox.layout.flex.horizontal
                          },
                          { -- Right
                            awful.titlebar.widget.floatingbutton (c),
                            awful.titlebar.widget.maximizedbutton(c),
                            awful.titlebar.widget.stickybutton   (c),
                            awful.titlebar.widget.ontopbutton    (c),
                            awful.titlebar.widget.closebutton    (c),
                            layout = wibox.layout.fixed.horizontal()
                          },
                          layout = wibox.layout.align.horizontal
                                                  }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
                        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
                        and awful.client.focus.filter(c) then
                          client.focus = c
                        end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- autostart script
function run_once(prg,arg_string,pname,screen)
  if not prg then
    do return nil end
  end

  if not pname then
    pname = prg
  end

  if not arg_string then 
    awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. ")",screen)
  else
    awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. " ".. arg_string .."' || (" .. prg .. " " .. arg_string .. ")",screen)
  end
end

-- fix the chrome notify large 
naughty.config.defaults['icon_size'] = 100

-- fix float always maximize
client.connect_signal("manage", function(c)
                        c.maximized = false
                        c.maximized_horizontal = false
                        c.maximized_vertical = false
end)


-- change the border radius
client.connect_signal("manage", function (c)
                        c.shape = function(cr,w,h)
                          gears.shape.rounded_rect(cr,w,h,2)
                        end
end)

-- Set Wallpaper
for s = 1, screen.count() do
  -- gears.wallpaper.maximized(beautiful.wallpaper, s, true)
  gears.wallpaper.maximized("/home/zhangtao/.config/awesome/default/background.png", s)
end


-- AutoStart

run_once("fcitx")
-- run_once("ibus-daemon")
--run_once("sslocal -c /home/zhangtao/.config/shadowscoks.json")
run_once("xflux -l 30 -g 120 -k 4200")
run_once("nm-applet")
-- run_once("emacs --daemon &")
--run_once("emacs &")
-- run_once("~/.dropbox-dist/dropboxd")
run_once("compton --backend glx --paint-on-overlay --vsync opengl-swc --config /home/zhangtao/.config/awesome/compton.conf")
-- run_once("compton --backend glx --paint-on-overlay --vsync opengl-swc)
-- run_once("xrandr --dpi 125")
run_once("xrdb -merge ~/.Xresources")
--run_once("sslocal -c /home/zhangtao/.config/shadowscoks.json")
--run_once("launchy")
-- run_once("konsole")
-- run_once("feh --bg-fill  /home/zhangtao/Dropbox/Picture/Wallpapers/geek-wallpaper-collection-1-stugon.com-14.jpg")
run_once("emacs --daemon")
-- run_once("/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh")
-- run_once("xrandr --output VIRTUAL1 --off --output eDP1 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output DP1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI2 --off --output HDMI1 --off --output DP2 --off")
run_once("syndaemon -t -k -i 2 -d &")
run_once("xfce4-power-manager &")
-- run_once("fluxgui")
-- run_once("xinput set-prop 11 "Device Enabled" 0")
-- run_once("xscreensaver -no-splash")
run_once("/usr/libexec/gsd-xsettings")
-- run_once("gnome-keyring-daemon")
run_once("/usr/bin/gnome-keyring-daemon --start --foreground --components=secrets")
-- run_once("/usr/lib/gnome-settings-daemon/gsd-xsettings")
run_once("touchegg")
-- run_once("todoist")
run_once("./trojan-1.14.1-linux-amd64/trojan/trojan trojan-1.14.1-linux-amd64/trojan/config.json")
run_once("albert")
-- run_once("./Dropbox/Apps/Shadowsocks-Qt5-3.0.1-x86_64.AppImage")

-- run_once("./Lotion/lotion")
