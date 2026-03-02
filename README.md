# dotfiles

Personal dotfiles for Arch Linux managed with a bare git repository.

## Contents

| Config | Description |
|--------|-------------|
| [Fish](#fish) | Priamry shell mirroring the Zsh setup |
| [Zsh](#zsh) | Secondary shell with Zinit, vi mode, fzf, zoxide, Starship |
| [Starship](#starship) | Cross-shell prompt — Catppuccin Mocha palette, vim-mode aware |
| [Neovim](#neovim) | NvChad v2.5 with LSP, DAP, Treesitter, Rust & Python support |
| [Kitty](#kitty) | Terminal emulator — Rosé Pine theme, low-latency tuning |
| [Zed](#zed) | Editor — Vercel Carbon Dark theme, vim mode, Space leader keymaps |
| [Lazygit](#lazygit) | TUI git client — Vercel-inspired theme, vi navigation |
| [Btop](#btop) | System monitor — Adapta theme, vi keys, braille graphs |
| [MPV](#mpv) | Media player — ModernZ OSC, thumbfast seek previews |
| [lsfg-vk](#lsfg-vk) | Vulkan Lossless Scaling frame generation per-game config |

---

## Installation

This repo uses the **bare git repository** pattern — files are tracked in-place inside `$HOME` with no symlinks or stow required.

### Fresh install on a new machine

```bash
# Clone as a bare repo
git clone --bare https://github.com/SlamZDank/dotfiles.git ~/.dotfiles

# Define the management alias (run once or add to your shell rc)
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Check out files into $HOME
dotfiles checkout

# Hide untracked files in status output
dotfiles config --local status.showUntrackedFiles no

# Pull in the Neovim submodule
dotfiles submodule update --init --recursive
```

If `checkout` fails due to existing files, back them up and try again:

```bash
mkdir -p ~/.dotfiles-backup
dotfiles checkout 2>&1 | grep '\s\+\.' | awk '{print $1}' | \
  xargs -I{} mv {} ~/.dotfiles-backup/{}
dotfiles checkout
```

---

## Configs

### Zsh

**Files:** `.zshrc`, `.zprofile`

- Plugin manager: [Zinit](https://github.com/zdharma-continuum/zinit) (auto-installs on first run)
- Plugins: `fzf-tab`, `zsh-syntax-highlighting`, `zsh-autosuggestions`, `zsh-history-substring-search`, `zsh-completions`
- OMZ snippets: git, sudo, archlinux, aws, kubectl, kubectx, command-not-found
- Full vi mode with cursor shape changes (beam insert / block normal)
- `p` in normal mode pastes from Wayland clipboard (`wl-paste`)
- Shell integrations: `fzf`, `zoxide` (replaces `cd`), Starship prompt
- Pacman aliases: `install`, `search`, `update`, `remove`
- `vim`/`nano` → `nvim`
- `.zprofile` sets Wayland env vars and includes an NVIDIA workaround for DaVinci Resolve

### Fish

**Files:** `.config/fish/config.fish`, `.config/fish/functions/su.fish`, `.config/fish/fish_variables`

Feature-for-feature mirror of the Zsh setup:
- Vi mode with `[N]`/`[I]`/`[V]` mode indicator in the prompt
- Same aliases, fzf, zoxide, Starship, and Wayland clipboard bindings
- `dotfiles` alias built in

### Starship

**File:** `.config/starship.toml`

- Color palette: Catppuccin Mocha
- Segments: OS icon → directory → git branch/status → language versions (C, Rust, Go, Node, PHP, Java, Kotlin, Haskell, Python) → conda → clock
- Vim-mode aware prompt character: `❯` (insert) / `❮` (normal/visual/replace) with distinct colors per mode

### Neovim

**Path:** `.config/nvim/` — git submodule → [SlamZDank/nvim-dots](https://github.com/SlamZDank/nvim-dots)

See the [nvim-dots readme](https://github.com/SlamZDank/nvim-dots) for full details.

- Base: NvChad, Lazy.nvim plugin management
- LSP with inline diagnostics, Blink completion, Treesitter + context
- DAP debugging
- Rust: rustaceanvim + crates.nvim
- Python venv support
- Gitsigns + Lazygit integration
- Auto-save, autopairs, surround

```bash
# Install standalone (without the dotfiles repo)
git clone https://github.com/SlamZDank/nvim-dots.git ~/.config/nvim
nvim  # plugins install automatically via Lazy.nvim
```

### Kitty

**Files:** `.config/kitty/kitty.conf`, `.config/kitty/current-theme.conf`

- Font: JetBrainsMono Nerd Font, size 12
- Theme: Rosé Pine (dark, slightly modified background)
- 50% background opacity with blur
- Low-latency tuning: `input_delay 0`, `repaint_delay 2`, `sync_to_monitor no`
- Remote control via unix socket at `/tmp/kitty-$USER`
- Wayland IME disabled

### Zed

**Files:** `.config/zed/settings.json`, `.config/zed/keymap.json`, `.config/zed/tasks.json`

- Theme: Vercel Carbon Dark; Icon theme: Catppuccin Latte
- Font: JetBrainsMono Nerd Font, size 16
- Vim mode with Space leader keybindings
- Relative line numbers, always-on minimap, autosave after 1s
- LSP: rust-analyzer (clippy on save), clangd (12 threads), basedpyright
- Formatters: stylua (Lua), prettier (CSS/HTML)
- Key highlights:
  - `Ctrl+H/J/K/L` — pane navigation
  - `Space+sv/so/sx/sm` — splits
  - `Space+ff/fw/fo` — finders
  - `Space+lg` — git panel
  - `Space+do/db/dx/dr` — debugger
- Predefined tasks: Rust (build/run/test/clippy), C/C++ (clang/clang++), Python, npm

### Lazygit

**File:** `.config/lazygit/config.yml`

- Theme: Vercel-inspired (pink active borders, purple search, dark backgrounds)
- Vi j/k navigation, hidden border style
- Topo-order git log with graph always visible
- Auto-fetch every 60s, auto-refresh every 10s
- Commit message auto-wrap at 72 chars

### Btop

**File:** `.config/btop/btop.conf`

- Theme: Adapta
- Vi keys (h/j/k/l/g/G)
- Braille graph symbols

### MPV

**Files:** `.config/mpv/mpv.conf`, `.config/mpv/scripts/`, `.config/mpv/script-opts/`

- Built-in OSC disabled; replaced with [ModernZ](https://github.com/Samillion/ModernZ)
- Seekbar: orange progress, chapter nibbles, [thumbfast](https://github.com/po5/thumbfast) thumbnail previews
- Jump buttons (±10s / ±60s), playlist controls, volume slider, yt-dlp download button
- Fluent + Material Design icon fonts

### lsfg-vk

**File:** `.config/lsfg-vk/conf.toml`

Vulkan layer config for [Lossless Scaling](https://store.steampowered.com/app/993090/Lossless_Scaling/) frame generation on Linux.

- Games configured: Hi-Fi RUSH,  Elden Ring, Chiaki (PS Remote Play), and generic entries
- Multipliers: 3× (games), 4× (benchmarks), 2× (Chiaki)

---

## Prerequisites

Most configs assume the following are installed:

- **Shell:** `zsh` or `fish`, `starship`, `fzf`, `zoxide`, `zinit`
- **Terminal:** `kitty`
- **Editor:** `neovim` >= 0.9, `zed`
- **Git TUI:** `lazygit`
- **Nerd Font:** JetBrainsMono Nerd Font (or any Nerd Font)
- **Wayland:** `wl-clipboard` for clipboard integration
- **Arch Linux:** `pacman` (for the shell aliases)
- **Optional:** `btop`, `mpv`, `yt-dlp`, `cargo`, `pnpm`, `nvidia-smi`
