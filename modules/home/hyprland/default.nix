{ pkgs, lib, config, inputs, ... }:
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
    
    WALLPAPER_DIR="/home/alqaholic/dotfiles/modules/home/wallpapers/"

    swww img $WALLPAPER_DIR$(ls $WALLPAPER_DIR |sort -R |tail -1)
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
  imports = [ ./config.nix ];
  home.packages = with pkgs; [
    screenshot
    random-wallpaper
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