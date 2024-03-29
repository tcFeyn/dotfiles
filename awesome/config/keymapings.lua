---@diagnostic disable: lowercase-global, undefined-global
local gears = require("gears")
local awful = require("awful")

terminal = "kitty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"
alt = "Mod1"

-- {{ Mouse bindings }}
root.buttons(gears.table.join(
    --awful.button({ }, 4, awful.tag.viewnext),
    --awful.button({ }, 5, awful.tag.viewprev),
))


-- {{ Sloppy focus }}
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

-- {{ keyboard bindings }}
globalkeys = gears.table.join(

    -- Window and screen manipulation
    awful.key({ modkey }, "h", function() awful.client.focus.global_bydirection("left") end ),
    awful.key({ modkey }, "j", function() awful.client.focus.global_bydirection("down")  end ),
    awful.key({ modkey }, "k", function() awful.client.focus.global_bydirection("up") end ),
    awful.key({ modkey }, "l", function() awful.client.focus.global_bydirection("right") end ),

    awful.key({ modkey, "Shift" }, "h", function() awful.client.swap.global_bydirection("left") end ),
    awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.global_bydirection("down")  end ),
    awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.global_bydirection("up") end ),
    awful.key({ modkey, "Shift" }, "l", function() awful.client.swap.global_bydirection("right") end ),

    awful.key({ modkey, "Control" }, "l", function() awful.tag.incmwfact( 0.05) end),
    awful.key({ modkey, "Control" }, "h", function() awful.tag.incmwfact(-0.05) end),

    awful.key({ modkey, "Control" }, "k", function() awful.client.incwfact( 0.05) end),
    awful.key({ modkey, "Control" }, "j", function() awful.client.incwfact(-0.05) end),

    awful.key({ modkey }, "i", function() awful.tag.incnmaster( 1, nil, true) end),
    awful.key({ modkey, "Shift" }, "i", function() awful.tag.incnmaster(-1, nil, true) end),

    awful.key({ modkey }, "u", function() awful.tag.incncol( 1, nil, true) end),
    awful.key({ modkey, "Shift" }, "u", function() awful.tag.incncol(-1, nil, true) end),

    awful.key({ modkey }, "s", function() awful.screen.focus_relative( 1) end),

    -- Tags
    awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag(mylayout) end),
    awful.key({ modkey, "Shift" }, "r", function () lain.util.rename_tag() end),
    awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end),   -- move to next tag
    awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end), -- move to previous tag
    awful.key({ modkey, "Shift" }, "d", function () lain.util.delete_tag() end),

    -- Volume Keys
    awful.key({}, "XF86AudioLowerVolume", function() awful.spawn.with_line_callback( "amixer -q -D pulse sset Master 5%-", { exit = function() volume_widget_timer:emit_signal("timeout") end }) end),
    awful.key({}, "XF86AudioRaiseVolume", function() awful.spawn.with_line_callback( "amixer -q -D pulse sset Master 5%+", { exit = function() volume_widget_timer:emit_signal("timeout") end }) end),
    awful.key({}, "XF86AudioMute", function() awful.spawn.with_line_callback( "amixer -D pulse set Master 1+ toggle", { exit = function() volume_widget_timer:emit_signal("timeout") end }) end),

    -- Media Keys
    awful.key({}, "XF86AudioPlay", function() awful.util.spawn("playerctl play-pause", false) end),
    awful.key({}, "XF86AudioNext", function() awful.util.spawn("playerctl next", false) end),
    awful.key({}, "XF86AudioPrev", function() awful.util.spawn("playerctl previous", false) end),

    -- Screenshots
    awful.key({ }, "Print", function() awful.spawn.with_shell('flameshot full -p ~/Pictures && notify-send -u normal "Print Screen Taken"') end),
    awful.key({ modkey }, "Print", function() awful.util.spawn('flameshot gui') end),

    -- Awesome Controls
    awful.key({ modkey, "Control" }, "F1", awesome.restart),
    awful.key({ modkey, "Control" }, "F3", awesome.quit),
    awful.key({ modkey }, "]", function() awful.layout.inc( 1) end),
    awful.key({ modkey }, "[", function() awful.layout.inc(-1) end),
    awful.key({ modkey }, "g", function () lain.util.useless_gaps_resize(1) end),
    awful.key({ modkey, "Shift" }, "g", function () lain.util.useless_gaps_resize(-1) end),

    -- Dmenu and Rofi scripts
    awful.key({ modkey }, "d", function() awful.spawn('dmenu_run') end),
    awful.key({ modkey }, "z", function() awful.spawn('run-script') end),
    awful.key({ modkey }, "p", function() awful.spawn('search-conf') end),
    awful.key({ modkey, "Shift"},  "p", function() awful.spawn('search-files') end),
    awful.key({ modkey, "Shift"},  "space", function() awful.spawn('clipmenu') end),
    awful.key({ alt }, "space", function() awful.spawn('rofi -show drun') end),
    awful.key({ modkey, "Control" }, "space", function() awful.spawn('mount_drive') end),
    awful.key({ modkey, "Control", "Shift" }, "space", function () awful.spawn('unmount_drive') end),
    awful.key({ modkey }, "space", function() awful.spawn.with_line_callback( "layout", { exit = function() keylayout_timer:emit_signal("timeout") end }) end),

    -- Toogle Wibar
    awful.key({ modkey }, "y", function() myscreen = awful.screen.focused() myscreen.mywibox.visible = not myscreen.mywibox.visible end ),

    -- Power Menu
    awful.key({ modkey, "Control" }, "F5", function() awful.spawn('shutdown now') end),
    awful.key({ modkey, "Control" }, "F6", function() awful.spawn('reboot') end),
    awful.key({ modkey, "Control" }, "F7", function() awful.spawn('systemctl suspend') end),
    awful.key({ modkey, "Control" }, "F8", function() awful.spawn('systemctl hibernate') end),

    -- Switch sound output
    awful.key({ modkey }, "F9", function() awful.spawn('pactl set-card-profile "alsa_card.pci-0000_2b_00.1" "off"') end),
    awful.key({ modkey }, "F10", function() awful.spawn('pactl set-card-profile "alsa_card.pci-0000_2b_00.1" "output:hdmi-stereo-extra4"') end),

    -- Programs
    awful.key({ modkey }, "Return", function() awful.spawn(terminal) end),
    awful.key({ modkey, alt }, "w", function() awful.spawn('librewolf') end),
    awful.key({ modkey, alt }, "f", function() awful.spawn('pcmanfm') end),
    awful.key({ modkey, alt }, "s", function() awful.spawn('pavucontrol') end),
    awful.key({ modkey, alt }, "k", function() awful.spawn('keepassxc') end),
    awful.key({ modkey, alt }, "p", function() awful.spawn('gpick') end),
    awful.key({ modkey, alt }, "m", function() awful.spawn('spotify') end),
    awful.key({ modkey, alt }, "t", function() awful.spawn('telegram-desktop') end),
    awful.key({ modkey, alt }, "d", function() awful.spawn('discord') end)

)

clientkeys = gears.table.join(

    awful.key({ modkey, "Control" }, "t", function(c) awful.titlebar.toggle(c) end),
    awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey }, "q", function(c) c:kill() end),
    awful.key({ modkey }, "f",  awful.client.floating.toggle),
    awful.key({ modkey, "Shift" }, "s", function(c) c:move_to_screen() end),
    awful.key({ modkey }, "b", function(c) c.minimized = true end),
    awful.key({ modkey, "Control" }, "b", function() local c = awful.client.restore() if c then c:emit_signal( "request::activate", "key.unminimize", {raise = true}) end end),
    awful.key({ modkey }, "n", function(c) c.fullscreen = not c.fullscreen c:raise() end),
    awful.key({ modkey }, "m", function(c) c.maximized = not c.maximized c:raise() end),
    awful.key({ modkey, "Control" }, "m", function(c) c.maximized_vertical = not c.maximized_vertical c:raise() end),
    awful.key({ modkey, "Shift" }, "m", function(c) c.maximized_horizontal = not c.maximized_horizontal c:raise() end),
    awful.key({ modkey }, "t", function(c) c.ontop = not c.ontop end),

    awful.key({ modkey, "Control" }, "p", function(c) bling.module.tabbed.pick(c) end),
    awful.key({ modkey, "Control" }, "r", function(c) bling.module.tabbed.pop(c) end),
    awful.key({ modkey, "Control" }, "", function(c) bling.module.tabbed.iter(c) end),
    awful.key({ modkey, "Control" }, "k", function() bling.module.tabbed.pick_by_direction("right") end),
    awful.key({ modkey, "Control" }, "j", function() bling.module.tabbed.pick_by_direction("left") end)

)

-- {{ Tags }}
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
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

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- {{ Set keys }}
root.keys(globalkeys)
