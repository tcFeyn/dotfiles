---@diagnostic disable: undefined-global
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local themes_path = gfs.get_configuration_dir()

local theme = {}

-- {{ Font }}
theme.font = "FantasqueSansMono Nerd Font 9.5"

-- {{ Colors }}
theme.fg_normal     = "#ECEFF4"
theme.fg_focus      = "#ECEFF4"
theme.fg_urgent     = "#D08770"
theme.fg_minimize   = "#ffffff"

theme.bg_normal     = "#2E3440"
theme.bg_focus      = "#363c4a"
theme.bg_urgent     = "#BF616A"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.useless_gap   = dpi(0)
theme.border_width  = dpi(0)
theme.border_normal = "#000000"
theme.border_focus  = "#363c4a"
theme.border_marked = "#91231c"

-- {{ Tags }}

-- Taglist squares:
--local taglist_square_size = dpi(4)
--theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
--    taglist_square_size, theme.fg_normal
--)
--theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
--    taglist_square_size, theme.fg_normal
--)

theme.taglist_spacing = dpi(5)

theme.taglist_bg_focus = theme.bg_normal
theme.taglist_fg_focus = "#81A1C1"
theme.taglist_bg_occupied = theme.bg_normal
theme.taglist_fg_occupied = theme.fg_urgent
theme.taglist_bg_empty = theme.bg_normal
theme.taglist_fg_empty = theme.fg_normal
theme.taglist_bg_urgent = theme.bg_urgent
theme.taglist_fg_urgent = theme.fg_urgent


-- {{ Notifications }}

theme.notification_font = "FantasqueSansMono Nerd Font 13"
theme.notification_bg = bg_normal
theme.notification_fg = fg_normal
theme.notification_max_width = 300
theme.notification_max_height = 100
--theme.notification_margin = 20
--theme.notification_border_color = "#81A1C1"
--theme.notification_border_width = 5
--theme.notification_width = 300
--theme.notification_height = 60

--naughty.config.defaults.margin = beautiful.notification_margin
naughty.config.defaults.padding = 20
naughty.config.defaults.position = "top_right"

theme.menu_submenu_icon = themes_path.."config/theme/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- {{ Title Bars }}
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.closebutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.minimizebutton(c),
            --awful.titlebar.widget.iconwidget(c),
            --buttons = buttons,
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
            --awful.titlebar.widget.floatingbutton(c),
            --awful.titlebar.widget.stickybutton(c),
            --awful.titlebar.widget.ontopbutton(c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal,
    }
end)

theme.titlebar_bg_focus   = "#363c4a"
theme.titlebar_bg_normal  = "#363c4a"

theme.titlebar_close_button_normal = themes_path .. "config/theme/titlebar/inactive.png"
theme.titlebar_close_button_focus  = themes_path .. "config/theme/titlebar/close.png"

theme.titlebar_minimize_button_normal = themes_path .. "config/theme/titlebar/inactive.png"
theme.titlebar_minimize_button_focus  = themes_path .. "config/theme/titlebar/minimize.png"

theme.titlebar_ontop_button_normal_inactive = themes_path .. "config/theme/titlebar/inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path .. "config/theme/titlebar/ontop.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "config/theme/titlebar/inactive.png"
theme.titlebar_ontop_button_focus_active  = themes_path .. "config/theme/titlebar/ontop.png"

theme.titlebar_sticky_button_normal_inactive = themes_path .. "config/theme/titlebar/inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path .. "config/theme/titlebar/sticky.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "config/theme/titlebar/inactive.png"
theme.titlebar_sticky_button_focus_active  = themes_path .. "config/theme/titlebar/sticky.png"

theme.titlebar_floating_button_normal_inactive = themes_path .. "config/theme/titlebar/inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path .. "config/theme/titlebar/floating.png"
theme.titlebar_floating_button_normal_active = themes_path .. "config/theme/titlebar/inactive.png"
theme.titlebar_floating_button_focus_active  = themes_path .. "config/theme/titlebar/floating.png"

theme.titlebar_maximized_button_normal_inactive = themes_path .. "config/theme/titlebar/inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path .. "config/theme/titlebar/maximize.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "config/theme/titlebar/inactive.png"
theme.titlebar_maximized_button_focus_active  = themes_path .. "config/theme/titlebar/maximize.png"

--theme.wallpaper = themes_path.."default/background.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."config/theme/layouts/fairhw.png"
theme.layout_fairv = themes_path.."config/theme/layouts/fairvw.png"
theme.layout_floating  = themes_path.."config/theme/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."config/theme/layouts/magnifierw.png"
theme.layout_max = themes_path.."config/theme/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."config/theme/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."config/theme/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."config/theme/layouts/tileleftw.png"
theme.layout_tile = themes_path.."config/theme/layouts/tilew.png"
theme.layout_tiletop = themes_path.."config/theme/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."config/theme/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."config/theme/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."config/theme/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."config/theme/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."config/theme/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."config/theme/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- {{ Icons }}
theme.icon_theme = "Papirus"

-- {{ Gaps }}
theme.useless_gap = 5
theme.gap_single_client = true

-- {{ Borders }}
--client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
--client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

return theme
