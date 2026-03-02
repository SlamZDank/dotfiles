if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    export GDK_BACKEND=wayland
    # export QT_QPA_PLATFORM=wayland
    export MOZ_ENABLE_WAYLAND=1
    export QT_SCREEN_SCALE_FACTORS="1;1"
    export __GL_THREADED_OPTIMIZATIONS=0
    export GTK_CSD=0
    export QT_QPA_PLATFORMTHEME=qt5ct
    # export QT_WAYLAND_DECORATION=adwaita
fi
# Davinci Resolve workaround because VM and Nvidia Driver are a bit quirky 🫠
nvidia-smi >> /dev/null

# to enable the qt5 themes because they look ugly by default
# export QT_QPA_PLATFORMTHEME=qt5ct:qt6ct
export NEOVIDE_VSYNC=0

# this causes a delay when gtk apps are loaded (Need to check the side effects)
export GTK_USE_PORTAL=1

path+=('/home/slamzdank/.cargo/bin/')

# Added by Toolbox App
export PATH="$PATH:/home/slamzdank/.local/share/JetBrains/Toolbox/scripts"
