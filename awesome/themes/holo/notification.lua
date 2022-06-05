local awful     = require("awful")
local beautiful = require("beautiful")
local gears     = require("gears")
local lain      = require("lain")
local naughty   = require("naughty")
local wibox     = require("wibox")

local dpi   = require("beautiful.xresources").apply_dpi

local theme = {}

theme.notification_shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 8)
end
theme.notification_border_color = "#0099CC"
theme.notification_spacing = 16

naughty.connect_signal("request::display", function(n)
    local vert_widget = {
        {
            naughty.widget.icon,
            {
                naughty.widget.title,
                naughty.widget.message,
                spacing = 4,
                layout  = wibox.layout.fixed.vertical,
            },
            fill_space = true,
            spacing    = 24,
            layout     = wibox.layout.fixed.horizontal,
        },
        spacing = 10,
        layout  = wibox.layout.fixed.vertical,
    }
    local margin_widget = {
        vert_widget,
        margins = 24,
        widget  = wibox.container.margin,
    }
    if n.actions and #n.actions > 0 then
        table.insert(vert_widget, naughty.list.actions)
    end
    local tmpl = {
        {
            margin_widget,
            id     = "background_role",
            widget = naughty.container.background,
        },
        width    = dpi(500),
        widget   = wibox.container.constraint,
    }
    naughty.layout.box {
        notification = n,
        widget_template = tmpl,
    }
end)

return theme
