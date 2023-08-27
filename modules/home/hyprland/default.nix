{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  mkService = lib.recursiveUpdate {
    Unit.PartOf = ["graphical-session.target"];
    Unit.After = ["graphical-session.target"];
    Install.WantedBy = ["graphical-session.target"];
  };
  screenshot = pkgs.writeShellScriptBin "screenshot" ''
    #!/usr/bin/env bash
    hyprctl keyword animation "fadeOut,0,8,slow" && ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -w 0 -b 5e81acd2)" - | swappy -f -; hyprctl keyword animation "fadeOut,1,8,slow"
  '';
  random-wallpaper = pkgs.writeShellScriptBin "random-wallpaper" ''
    #!/usr/bin/env bash

    WALLPAPER_DIR="/home/alqaholic/dotfiles/config/wallpapers/"

    swww img $WALLPAPER_DIR$(ls $WALLPAPER_DIR |sort -R |tail -1) \
      --transition-type grow \
      --transition-pos 0.00001,0.99999 \
      --transition-step 90
  '';
  wallpaper-menu = pkgs.writeShellScriptBin "wallpaper-menu" ''
    #!/usr/bin/env bash

    WALLPAPER_DIR="/home/alqaholic/dotfiles/config/wallpapers/"
    LIST=($(ls $WALLPAPER_DIR))
    CURRENT_WALLPAPER=$(swww query | awk '{ print $8 }')

    if [ "$@" ]
    then
      swww img $WALLPAPER_DIR$1 \
              --transition-type grow \
              --transition-pos 0.00001,0.99999 \
              --transition-step 90
      CURRENT_WALLPAPER="$WALLPAPER_DIR$1"
    fi

    echo -en "\x00prompt\x1fSelect a wallpaper\n"
    echo -en "\0keep-selection\x1ftrue\n"
    echo -en "\0message\x1fPress <b>enter</b> to set wallpaper and <b>esc</b> to exit\n"

    index=0
    for value in "''${LIST[@]}"
    do
      if [ z"$WALLPAPER_DIR$value" = z"$CURRENT_WALLPAPER" ]
      then
        echo -en "\0active\x1f$index\n"
      fi
      echo -ne "$value\0info\x1f$index\n"
      ((index++))
    done
  '';
  power-menu = pkgs.writeShellScriptBin "power-menu" ''
    #!/usr/bin/env bash

    rofi \
      -show p \
      -modi p:'rofi-power-menu --symbols-font "RobotoMono Nerd Font Mono" --choices shutdown/reboot/hibernate/suspend' \
      -font "Roboto Mono NF 16" \
      -theme-str 'listview {lines: 4;}'
  '';
in {
  imports = [./config.nix];
  home.packages = with pkgs; [
    screenshot
    random-wallpaper
    wallpaper-menu
    power-menu

    hyprpaper
    swww
    eww-wayland
    waybar

    libnotify
    dunst

    rofi-wayland
    rofimoji
    rofi-bluetooth
    rofi-power-menu

    brightnessctl
    pamixer
    grim
    slurp
    swappy
    wl-clipboard
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default.override {
      enableNvidiaPatches = true;
    };
    systemdIntegration = true;
  };

  # fake a tray to let apps start
  # https://github.com/nix-community/home-manager/issues/2064
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
    };
  };

  # systemd.user.services = {
  #   swww = mkService {
  #     Unit.Description = "Wallpaper chooser";
  #     Service = {
  #       ExecStart = "${lib.getExe pkgs.swww} init --no-daemon";
  #       Restart = "no";
  #     };
  #   };
  # };
}
