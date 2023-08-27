{
  config,
  pkgs,
  ...
}: {
  programs.zsh.enable = true;
  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      alqaholic = {
        description = "Rohit Krishnan";
        uid = 1000;
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "docker"
          "systemd-journal"
          "audio"
          "plugdev"
          "wireshark"
          "video"
          "input"
          "lp"
          "networkmanager"
          "power"
          "nix"
        ];
        shell = pkgs.zsh;
      };
    };
  };
}
