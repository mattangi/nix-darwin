{ pkgs }:

with pkgs; [
    # Shell, terminal emulator, ...
    zsh
    oh-my-zsh
    zsh-powerlevel10k
    zsh-autosuggestions
    zsh-syntax-highlighting
    yazi

    # Base CLI tools
    colorls
    zoxide
    bat
    ripgrep
    neovim
    mkalias
    ffmpegthumbnailer
    ffmpeg
    p7zip
    jq
    poppler
    fd
    fzf
    fzf-git-sh
    imagemagick
    dockutil
    nodejs
    eza
    tldr
    vim
    neofetch
    lazygit

    # GPG and yubikey
    gnupg
    pinentry_mac

    # fonts
    vimPlugins.mini-icons
    vimPlugins.nvim-web-devicons
    
    # all the other apps
    obsidian
    vscode
    arc-browser
    alt-tab-macos
    zoom-us
    aerospace
    raycast
]
