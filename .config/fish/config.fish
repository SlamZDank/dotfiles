# =============================================================================
# BASIC SETTINGS
# =============================================================================

set -g fish_history_size 5000

# =============================================================================
# PROMPT
# =============================================================================

function fish_prompt
    set -l cwd (prompt_pwd)
    printf '\e[5 q'               # Beam cursor
    echo -n "$USER@$(hostname) $cwd> "
end

function fish_mode_prompt
    switch $fish_bind_mode
        case default
            echo -n '[N] '
        case insert
            echo -n '[I] '
        case visual
            echo -n '[V] '
    end
end

# =============================================================================
# ALIASES
# =============================================================================

alias ls="ls -al"

function killwine
    kill -9 (ps aux | grep -i '\.exe' | awk '{print $2}' | tr '\n' ' ')
end

alias vesktop="vesktop --enable-features=UseOzonePlatform --ozone-platform=wayland"

alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"


# Arch Linux package management
alias install="sudo pacman -S"
alias search="sudo pacman -Ss"
alias update="sudo pacman -Sy archlinux-keyring --needed && sudo pacman -Su"
alias remove="sudo pacman -Rs"

# General convenience
alias ls="ls --color"
alias vim="nvim"
alias nano="nvim"
alias c="clear"

# =============================================================================
# ENVIRONMENT VARIABLES
# =============================================================================

set -gx EDITOR "nvim"
set -gx VISUAL "nvim"

# pnpm
set -gx PNPM_HOME "/home/slamzdank/.local/share/pnpm"
if not string match -q -- "*:$PNPM_HOME:*" ":$PATH:"
    set -gx PATH "$PNPM_HOME" $PATH
end

# =============================================================================
# CLIPBOARD FUNCTIONS (Wayland)
# =============================================================================

function fish_clipboard_copy
    echo -n (commandline) | wl-copy
end

function fish_clipboard_paste
    commandline -i (wl-paste 2>/dev/null | string collect)
end

# =============================================================================
# KEY BINDINGS
# =============================================================================

function fish_user_key_bindings
    fish_vi_key_bindings

    bind \cU backward-kill-line
    bind \e\[3\;5~ kill-word
    bind \e\[3~ delete-char
    bind \e\[1\;5C forward-word
    bind \e\[1\;5D backward-word
    bind \e\[5~ beginning-of-history
    bind \e\[6~ end-of-history
    bind \e\[H beginning-of-line
    bind \e\[F end-of-line
    bind \e\[Z undo
    bind \cH backward-kill-word

    # History search on arrow keys
    bind \e\[A history-search-backward
    bind \e\[B history-search-forward

    # Wayland clipboard bindings
    if test "$XDG_SESSION_TYPE" = "wayland"
        bind -M visual y "fish_clipboard_copy; commandline -f end-selection repaint-mode"
        bind -M insert \cV fish_clipboard_paste
    end
end

# =============================================================================
# PLUGINS (via Fisher)
# =============================================================================

# Install plugins manually once:
# fisher install jorgebucaran/fisher
# fisher install PatrickF1/fzf.fish
# fisher install franciscolourenco/done
# fisher install decors/fish-colored-man

# =============================================================================
# SHELL INTEGRATIONS
# =============================================================================

# fzf (if installed)
if status is-interactive && command -v fzf >/dev/null
    fzf --fish | source
end

# zoxide (cd replacement)
if command -v zoxide >/dev/null
    zoxide init fish | source

    function cd
        z $argv
    end
end

# Starship prompt (if not in TTY and installed)
if test "$XDG_SESSION_TYPE" != "tty" && command -v starship >/dev/null
    starship init fish | source
end

# =============================================================================
# TTY-SPECIFIC SETTINGS
# =============================================================================

if test "$XDG_SESSION_TYPE" = "tty"
    setfont ter-v18b 2>/dev/null
    clear
end

# =============================================================================
# JETBRAINS VM OPTIONS (if present)
# =============================================================================

set -l jb_vmoptions "$HOME/.jetbrains.vmoptions.sh"
if test -f "$jb_vmoptions"
    source "$jb_vmoptions"
end

# =============================================================================
# LOGIN SHELL ONLY
# =============================================================================

if status --is-login
    # Wayland Environment Variables
    if test "$XDG_SESSION_TYPE" = "wayland"
        set -gx GDK_BACKEND wayland
        # set -gx QT_QPA_PLATFORM wayland   # Uncomment if needed
        set -gx MOZ_ENABLE_WAYLAND 1
        set -gx QT_SCREEN_SCALE_FACTORS "1;1"
        set -gx __GL_THREADED_OPTIMIZATIONS 0
        set -gx GTK_CSD 0
        set -gx QT_QPA_PLATFORMTHEME qt5ct
        # set -gx QT_WAYLAND_DECORATION adwaita
    end

    # NVIDIA / DaVinci Resolve Workaround
    nvidia-smi >/dev/null 2>&1

    # Qt/GTK Theme & Performance Tweaks
    set -gx NEOVIDE_VSYNC 0
    set -gx GTK_USE_PORTAL 1

    # PATH Modifications
    fish_add_path $HOME/.cargo/bin
    fish_add_path $HOME/.local/share/JetBrains/Toolbox/scripts
end
