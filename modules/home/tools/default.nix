{
  pkgs,
  lib,
  config,
  ...
}: let
  browser = ["google-chrome.desktop"];

  associations = {
    "text/html" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/unknown" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/xhtml+xml" = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht" = browser;

    "audio/*" = ["mpv.desktop"];
    "video/*" = ["mpv.dekstop"];
    "image/png" = ["org.gnome.eog.desktop"];
    "image/jpg" = ["org.gnome.eog.desktop"];
    "image/jpeg" = ["org.gnome.eog.desktop"];
    "application/json" = browser;
    "application/pdf" = ["org.pwmt.zathura.desktop.desktop"];
    "x-scheme-handler/tg" = ["telegramdesktop.desktop"];
    "x-scheme-handler/spotify" = ["spotify.desktop"];
    "x-scheme-handler/discord" = ["discord.desktop"];
  };
in {
  services = {
    udiskie.enable = true;
    gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
      enableSshSupport = true;
      enableZshIntegration = true;
    };
  };

  programs = {
    gpg.enable = true;
    man.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    bat = {
      enable = true;
      config = {
        pager = "less -FR";
      };
      # themes = {};
    };
  };

  services.easyeffects = {
    enable = true;
  };

  xdg = {
    userDirs = {
      enable = true;
      documents = "/home/alqaholic/documents";
      download = "/home/alqaholic/downloads";
      videos = "/home/alqaholic/videos";
      music = "/home/alqaholic/music";
      pictures = "/home/alqaholic/pictures";
      desktop = "/home/alqaholic/other";
      publicShare = "/home/alqaholic/other";
      templates = "/home/alqaholic/other";
    };
    mimeApps.enable = true;
    mimeApps.associations.added = associations;
    mimeApps.defaultApplications = associations;
  };
}
