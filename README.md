# Dotfiles

This repository contains my personal dotfiles for various terminal applications and tools, managed with GNU Stow.

## 📦 What's Included

- 🐱 **kitty**: Terminal emulator configuration with Catppuccin Mocha theme
- 👻 **ghostty**: Alternative terminal emulator settings
- 🚀 **starship**: Cross-shell customizable prompt with colorful segments
- 🎨 **ohmyposh**: Prompt theme engine with customizable segments and icons
- 📟 **tmux**: Terminal multiplexer with custom key bindings and settings
- 🐚 **zsh**: Z shell configuration with zinit plugin manager
- 📊 **waybar**: Highly customizable Wayland status bar

## 🔧 Requirements

- [GNU Stow](https://www.gnu.org/software/stow/) - Symlink farm manager

## 💾 Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Use GNU Stow to symlink the configurations you want:
    ```bash
    # Example: to install zsh configuration
    stow zsh

    # For tmux
    stow tmux

    # For kitty
    stow kitty
    
    # For ohmyposh
    stow ohmyposh

    # For all configurations
    stow */
    ```

## 🎨 Terminal Theme

The configurations use the Catppuccin Mocha theme for a consistent look across applications.

## ⚙️ Customization

Feel free to fork this repository and modify any configuration files to suit your preferences.