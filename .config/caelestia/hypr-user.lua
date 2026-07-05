hl.monitor({
    output   = "DP-1",
    mode     = "1920x1080@165",
    position = "0x310",
    scale    = 1.0,
    vrr      = 2,
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "preferred",
    position = "-1536x636",
    scale    = 1.25,
})

hl.config({
    input = {
        kb_options = "caps:escape_shifted_capslock,shift:both_capslock_cancel",
    },
})

hl.animation({ leaf = "layersIn",    enabled = true, speed = 4, bezier = "emphasizedDecel", style = "slide" })
hl.animation({ leaf = "layersOut",   enabled = true, speed = 4, bezier = "emphasizedDecel", style = "slide" })
hl.animation({ leaf = "fadeLayers",  enabled = true, speed = 4, bezier = "standard" })
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 4, bezier = "emphasizedDecel" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 4, bezier = "emphasizedAccel" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "standard" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 4, bezier = "standard" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4, bezier = "specialWorkSwitch", style = "slidefadevert 15%" })
hl.animation({ leaf = "fade",        enabled = true, speed = 4, bezier = "standard" })
hl.animation({ leaf = "fadeDim",     enabled = true, speed = 4, bezier = "standard" })
hl.animation({ leaf = "border",      enabled = true, speed = 4, bezier = "standard" })

hl.env("TERMINAL", "kitty")
hl.env("HYPRSHOT_DIR", "/home/slamzdank/Pictures/Screenshots")

hl.bind("SUPER + CAPS", hl.dsp.exec_cmd("ydotool key 58:1 58:0"))

hl.bind("Insert", hl.dsp.exec_cmd("hyprshot -m region -c"), { locked = true })
hl.bind("SUPER + Insert", hl.dsp.exec_cmd("hyprshot -m output -c"), { locked = true })
hl.bind("SHIFT + Insert", hl.dsp.exec_cmd("hyprshot -m region --freeze -c"), { locked = true })
hl.bind("SUPER + SHIFT + K", hl.dsp.exec_cmd("/home/slamzdank/.local/bin/caelestia-shortcuts"))

hl.config({misc = {disable_splash_rendering = true}}) 

-- Override: don't auto-send to special workspaces
hl.window_rule({
    match  = { class = "org.freedesktop.impl.portal.desktop.kde" },
    size   = "(monitor_w*0.6) (monitor_h*0.7)",
    center = true,
})

hl.env("XCURSOR_THEME", "AppleX-Light")
hl.env("XCURSOR_SIZE", "38")

hl.env("GDK_BACKEND", "wayland")
hl.env("QT_SCREEN_SCALE_FACTORS", "1;1")
hl.env("__GL_THREADED_OPTIMIZATIONS", 0)
hl.env("GTK_CSD", 0)

hl.exec_cmd("sleep 1 && hyprctl setcursor AppleX-Light 38")
hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'AppleX-Light'")
hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size 38")
