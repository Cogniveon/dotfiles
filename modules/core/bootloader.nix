{ config, pkgs, lib, inputs, ... }: {
  boot = {
    initrd.verbose = false;

    loader = {
      # systemd-boot.enable = true;
      # efi.canTouchEfiVariables = true;

      grub = {
        enable = true;
        devices = ["nodev"];
        efiInstallAsRemovable = true;
        efiSupport = true;
        useOSProber = true;

        theme = pkgs.stdenv.mkDerivation {
          pname = "distro-grob-themes";
          version = "3.1";
          src = pkgs.fetchFromGitHub {
            owner = "AdisonCavani";
            repo = "distro-grub-themes";
            rev = "v3.1";
            hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
          };
          installPhase = "cp -r customize/nixos $out";
        };
      };
    };
  };
}