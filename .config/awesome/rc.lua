-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")

-- Load Debian menu entries
require("debian.menu")

require("h2eroUtil")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/home/h2ero/.config/awesome/themes/default/theme.lua")

-- {{{开机启动
-- conky
--awful.util.spawn("conky -c /home/h2ero/.conky/conky_grey/conkyrc_grey")
-- 透明效果
awful.util.spawn("xcompmgr")
-- 网络管理
awful.util.spawn("nm-applet")
awful.util.spawn("xmodmap /home/h2ero/.Xmodmap")
-- }}}

-- This is used later as the default terminal and editor to run.
--terminal = "x-terminal-emulator"
terminal = "urxvt"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

--change menu key
awful.menu.menu_keys = { up = { "Up", "k" },
              down = { "Down", "j" },
              back = { "Left", "h" },
              exec = { "Return", "Right", "l"},
              enter = { "Right", "l" },
              close = { "Escape" } }
-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    --awful.layout.suit.max,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.left,
    awful.layout.suit.floating,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.left,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.tile,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.floating,
    --awful.layout.suit.tile.top,
    --awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max.fullscreen
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}

for s = 1,screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(
    {   
        "1≯web",
        "2≯dev",
        "3≯hack",
        "4≯bgrun",
        "5≯doc",
        "6≯tem",
        "7≯emacs",
        "8≯gvim",
        "9≯video",
    }
    , s, layouts)
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myapp= {
   { "manual", terminal .. " -e man awesome" },
   { "firefox","firefox" },
   { "nautilus","nautilus --no-desktop" }, 
   { "vmplayer","vmplayer" },
   { "zendstudio","/media/software/developTool/ZendStudio/ZendStudio" },
   { "AptanaStudio3","/media/software/developTool/Aptana/AptanaStudio3" },
   { "Sublime Text 2","/media/software/developTool/SublimeText2/sublime_text" },
   { "balsamiq","/media/software/developTool/balsamiq" },
   { "osdlyrics","osdlyrics" },
   { "virtualbox","virtualbox" },
   { "shutdown","shutdown -h now" },
   { "gvim","gvim" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myapp, beautiful.awesome_icon },
                                    { "Debian", debian.menu.Debian_menu.Debian },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
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
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

-- h2ero widget --------------------------------------------------------------------------------
--
-- ip
local ipwidget = widget({type = "textbox"})
ipwidget.text  = "IP:"..getIp()
awful.widget.layout.margins[ipwidget] = { right = 5 }
ipwidget.right=15

-- volume
local volumewidget = widget({type = "textbox"})
volumewidget.text  = "Vol:"..getVolume()
awful.widget.layout.margins[volumewidget] = { right = 5 }
volumewidget.right=15

local loadWidget = widget({type = "textbox"})

awful.widget.layout.margins[volumewidget] = { right = 5 }
loadWidget.right=15
mytimer = timer({ timeout = 1 })
mytimer:add_signal("timeout", function() loadWidget.text = getLoad() end)
mytimer:start()


-- h2ero widget end --------------------------------------------------------------------------------

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)


    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", opacity=0.6, screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        mytextclock,
        s == 1 and mysystray or nil,
        ipwidget,
        volumewidget,
        layout = awful.widget.layout.horizontal.rightleft
    }
    mywibox[s] = awful.wibox({ position = "bottom", opacity=0.6, screen = s })
    mywibox[s].widgets = {
        loadWidget,
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}
runapp={ "firefox",
		"vmplayer",
		"/media/software/developTool/ZendStudio/ZendStudio",
		"/media/software/developTool/Aptana/AptanaStudio3",
		"/media/software/developTool/SublimeText2/sublime_text",
		"scrot -e 'mv $f ~/Desktop/temp/ 2>/dev/null'",
		"mysql-workbench",
		"gvim"
}
-- {{{ Key bindings
globalkeys = awful.util.table.join(
    ---Application ShortCut
    awful.key({ modkey,"Control"}, "f", function () awful.util.spawn(runapp[1]) end),
    awful.key({ modkey,"Control"}, "v", function () awful.util.spawn(runapp[8]) end),
    awful.key({ modkey,"Control"}, "z", function () awful.util.spawn(runapp[3]) end),
    awful.key({ modkey,"Control"}, "a", function () awful.util.spawn(runapp[4]) end),
    awful.key({ modkey,"Control"}, "s", function () awful.util.spawn(runapp[5]) end),
    awful.key({ modkey,"Control"}, "x", function () awful.util.spawn(runapp[6]) end),
    awful.key({ modkey,"Control"}, "w", function () awful.util.spawn(runapp[7]) end),
    
    awful.key({ modkey }, "m", function () awful.util.spawn_with_shell("mute") end),
    awful.key({ modkey }, "=", function () setVolume("+4"); volumewidget.text  = getVolume(); end),
    awful.key({ modkey }, "-", function () setVolume("-4"); volumewidget.text  = getVolume(); end),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
    awful.key({ modkey,           }, "j",
            function ()
                awful.client.focus.byidx( 1)
                if client.focus then client.focus:raise() end
            end),
    awful.key({ modkey,           }, "k",
            function ()
                awful.client.focus.byidx(-1)
                if client.focus then client.focus:raise() end
            end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),
    
    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "F1",
            function ()
                awful.client.focus.history.previous()
                if client.focus then
                    client.focus:raise()
                end
            end),
        -- Standard program
    --awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal.." -e tmux") end),
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),
    
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Control" }, "k",     function () awful.client.incwfact( 0.05)    end),
    awful.key({ modkey, "Control" }, "j",     function () awful.client.incwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
    
    awful.key({ modkey, "Control" }, "n", awful.client.restore),
    
    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),
    
    awful.key({ modkey }, "x",
                  function ()
                      awful.prompt.run({ prompt = "Run Lua code: " },
                      mypromptbox[mouse.screen].widget,
                      awful.util.eval, nil,
                      awful.util.getdir("cache") .. "/history_eval")
                  end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,           }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "Totem" },
      properties = { floating = true,tag=tags[1][5]} },
    ---{ rule = { class = "Firefox" },
     -- properties = { tag=tags[1][1]} },
    --{ rule = { class = "Gnome-terminal" },
     -- properties = { tag=tags[1][2]} },
    { rule = { class = "Audacious" },
      properties = {floating = true,tag=tags[1][5]} },
    --{ rule = { class = "gnome-terminal" },
     -- properties = {floating = true,tag=tags[1][2]} },
 	{ rule = { instance = "plugin-container" },
      properties = { floating = true } },
    { rule = { class = "Osdlyrics" },
      properties = { floating = true } },
    { rule = { class = "wine" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
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
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
