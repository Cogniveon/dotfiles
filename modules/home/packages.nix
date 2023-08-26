{pkgs, ...}: {
  nixpkgs.config.allowUnfree = false;
  home.packages = with pkgs; [
    # Apps
    alacritty
    neovide
    vlc
    gimp
    google-chrome
    vscode
    discord
    # Use spicetify
    # spotify
    transmission-gtk
    gnome.nautilus
    gnome.eog
    gnome.gnome-tweaks
    gnome.dconf-editor
    lxappearance
    blueman
    networkmanagerapplet

    # CLI tools
    zsh
    starship
    neovim
    exa
    bat
    catimg
    wget
    curl
    git
    brightnessctl
    pamixer
    playerctl
    cava
    neofetch
    mpc-cli
    xdg-user-dirs
    zip
    unzip
    rsync
    ffmpeg
    gnumake
    jq
    glib
    dconf

    # Coding stuff
    python3
    gcc
    go
    rustup
    nodejs_latest
    deno
    nodePackages.yarn
    lua
    lua-language-server
  ];
}