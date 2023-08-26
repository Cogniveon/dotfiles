{ nixpkgs, self, ... }: let
  inherit (self) inputs;
  bootloader = ../modules/core/bootloader.nix;
  core = ../modules/core;
  nvidia = ../modules/nvidia;
  wayland = ../modules/wayland;

  hw = inputs.nixos-hardware.nixosModules;
in {
  # Acer Aspire A715-41G
  # CPU: AMD Ryzen 5 3550H with Radeon Vega Mobile
  # GPU: NVIDIA GeForce GTX 1650 Ti Mobile
  "rk-acerlap" = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      { networking.hostName = "rk-acerlap"; }
      ./rk-acerlap/hardware-configuration.nix
      bootloader
      nvidia
      wayland
      core
    ];

    specialArgs = {inherit inputs;};
  };
}