---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = "~/.config/awesome/"

local theme = {}

theme.font          = "Monaco for Powerline Bold 10"

theme.bg_normal     = "#000000"
theme.bg_focus      = "#666666"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal


theme.fg_normal     = "#ffffff"
theme.fg_focus      = "#ffffff"
-- theme.fg_focus      = "#ebebf5"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap = dpi(0)
theme.useless_gap_edge_left = 0
theme.useless_gap_edge_bottom = 0
-- theme.useless_gap_edge_top = -1
theme.useless_gap_edge_right = 0

-- theme.border_radius = dpi(10)
-- theme.panel_widget_border_radius = dpi(10)

local gears = require('gears')
local less_rounded_rect_shape = function(cr,w,h)
  gears.shape.rounded_rect(
    cr, w, h, 3
  )
end

-- Taglist
theme.taglist_shape = less_rounded_rect_shape
-- theme.taglist_bg = "#6f15cb"
-- theme.taglist_bg_focus = "#767680"
theme.taglist_bg_focus = "#666666"
theme.taglist_fg_focus = "#ffffff"

-- Tasklist
theme.tasklist_shape = less_rounded_rect_shape
-- theme.tasklist_bg_focus = "#b75ebc"

-- Notification
theme.notification_shape = function(cr,w,h)
  gears.shape.rounded_rect(
    cr, w, h, theme.notification_border_radius
  )
end

-- Border
theme.border_width  = dpi(1)
theme.border_normal = "#000000"
theme.border_tooltip =  "#000000"
theme.border_focus = "#545458"
theme.border_marked = "#000000"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
  taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
  taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(20)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

theme.wallpaper = themes_path.."default/background.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairh.png"
theme.layout_fairv = themes_path.."default/layouts/fairv.png"
theme.layout_floating  = themes_path.."default/layouts/floating.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifier.png"
theme.layout_max = themes_path.."default/layouts/max.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreen.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottom.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleft.png"
theme.layout_tile = themes_path.."default/layouts/tile.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletop.png"
theme.layout_spiral  = themes_path.."default/layouts/spiral.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindle.png"
-- theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
-- theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
-- theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
-- theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
  theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- theme.gap_single_client  = false

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
