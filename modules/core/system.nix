{ config, pkgs, lib, ... }: {
  services = {
    dbus = {
      packages = with pkgs; [dconf gcr udisks2];
      enable = true;
    };
    udev.packages = with pkgs; [gnome.gnome-settings-daemon android-udev-rules ledger-udev-rules];
    journald.extraConfig = ''
      SystemMaxUse=50M
      RuntimeMaxUse=10M
    '';
    udisks2.enable = true;
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 16*1024;
  }];

  environment.systemPackages = with pkgs; [
    git
    appimage-run
    (writeScriptBin "sudo" ''exec doas "$@"'')
    stdenv.cc.cc
    openssl
    curl
    glib
    util-linux
    glibc
    icu
    libunwind
    libuuid
    zlib
    libsecret
    # graphical
    freetype
    libglvnd
    libnotify
    SDL2
    vulkan-loader
    gdk-pixbuf
  ];

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  programs = {
    # type "fuck" to fix the last command that made you go "fuck"
    thefuck.enable = true;

    # help manage android devices via command line
    adb.enable = true;

    java = {
      enable = true;
      package = pkgs.jre;
    };
  };
}