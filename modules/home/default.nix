{
  inputs,
  pkgs,
  config,
  lib,
  self,
  hostname,
  ...
}: {
  imports = [
    inputs.spicetify-nix.homeManagerModule

    ./packages.nix
    ./gtk
    ./git
    ./shell
    ./tools
    ./media
    ./dunst
    ./hyprland
    ./spicetify
  ];

  config = {
    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "23.05"; # Please read the comment before changing.

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home = {
      username = "alqaholic";
      homeDirectory = "/home/alqaholic";
    };

    home.extraOutputsToInstall = ["doc" "devdoc"];

    home.file = {
      ".config/alacritty/alacritty.yml".source = ../../config/alacritty.yml;
      ".config/neofetch/config.conf".source = ../../config/neofetch.conf;
      ".config/cava/config".source = ../../config/cava.conf;

      ".config/waybar/config".source = ../../config/waybar/config.json;
      ".config/waybar/style.css".source = ../../config/waybar/style.css;

      ".config/rofi" = {
        source = ../../config/rofi;
        recursive = true;
      };

      ".config/nvim" = {
        source = ../../config/nvim;
        recursive = true;
      };
    };
  };
}
