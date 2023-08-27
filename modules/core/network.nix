{
  config,
  pkgs,
  lib,
  ...
}: {
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [docker-compose speedtest-cli];
  networking = {
    networkmanager = {
      enable = true;
      unmanaged = ["docker0" "rndis0"];
      wifi.macAddress = "random";
    };
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # slows down boot time
  systemd.services.NetworkManager-wait-online.enable = false;
}
