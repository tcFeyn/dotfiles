---@diagnostic disable: undefined-global, lowercase-global
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local api = require("../config/api")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- {{ Widgets }}
local calendar_widget = require("widgets.calendar-widget.calendar")
mytextclock = wibox.widget.textclock()
local cw = calendar_widget({
    theme = 'nord',
    placement = 'top_right',
    radius = 8,
})
mytextclock:connect_signal("button::press",
    function(_, _, _, button)
        if button == 1 then cw.toggle() end
    end)
local volume_widget = require('widgets.volume-widget.volume')
local net_speed_widget = require("widgets.net-speed-widget.net-speed")
local logout_menu_widget = require("widgets.logout-menu-widget.logout-menu")
local keylayout = awful.widget.keyboardlayout()
local system_usage = awful.widget.watch('s-system_usage', 5)
local weather_widget = require("../widgets/weather-widget.weather")
local spotify_widget = require("../widgets/spotify-widget.spotify")

per = wibox.widget.textbox("%")
separator = wibox.widget.textbox("  ")


-- {{ Wibar }}

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
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

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))


local function setup_any_screen(s)
    awful.tag({ " ", " ", " ", " ", " "}, s, awful.layout.layouts[1])

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })
end

local function setup_wibox_on_primary_screen(s)
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mylayoutbox,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            net_speed_widget(),
            separator,
            system_usage,
            separator,
            volume_widget{ widget_type = 'icon_and_text' },
            per,
            separator,
            keylayout,
            separator,
            mytextclock,
            separator,
            logout_menu_widget(),
        },
    }
end

local function setup_wibox_on_secondary_screen(s)
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mylayoutbox,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            separator,
            spotify_widget({
               font = 'FantasqueSansMono Nerd Font',
               play_icon = '/usr/share/icons/Papirus-Light/24x24/categories/spotify.svg',
               pause_icon = '/usr/share/icons/Papirus-Dark/24x24/panel/spotify-indicator.svg',
               dim_when_paused = true,
               dim_opacity = 0.5,
               max_length = 50,
               show_tooltip = true,
               timeout = 5
            }),
            separator,
            weather_widget({
                api_key= api,
                coordinates = {41.1496100, -8.6109900},
                time_format_12h = true,
                units = 'metric',
                both_units_widget = false,
                font_name = 'FantasqueSansMono Nerd Font',
                icons = 'VitalyGorbachev',
                icons_extension = '.svg',
                show_hourly_forecast = true,
                show_daily_forecast = true,
            }),
            separator,
            mytextclock,
            wibox.widget.systray(),
        },
    }
end

local function setup_wibox_on_screen(s)
    if s == screen.primary then
        setup_wibox_on_primary_screen(s)
    else
        setup_wibox_on_secondary_screen(s)
    end
end

awful.screen.connect_for_each_screen(function(s)
    setup_any_screen(s)
    setup_wibox_on_screen(s)
end)
