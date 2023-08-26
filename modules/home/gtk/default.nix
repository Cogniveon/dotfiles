{ self, pkgs, lib, config, inputs, ... }: {

  gtk = {
    enable = true;
    iconTheme = {
      name = "gruvbox-dark-icons-gtk";
      package = pkgs.gruvbox-dark-icons-gtk;
    };

    theme = {
      name = "gruvbox-dark";
      package = pkgs.gruvbox-dark-gtk;
    };

    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 16;
    };
  };

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 16;
    gtk.enable = true;
    x11.enable = true;
  };

  qt = {
    enable = true;

    # platform theme "gtk" or "gnome"
    platformTheme = "gtk";

    # name of the qt theme
    style.name = "adwaita-dark";

    # detected automatically:
    # adwaita, adwaita-dark, adwaita-highcontrast,
    # adwaita-highcontrastinverse, breeze,
    # bb10bright, bb10dark, cde, cleanlooks,
    # gtk2, motif, plastique

    # package to use
    style.package = pkgs.adwaita-qt;
  };

  home.sessionVariables = {
    XCURSOR_SIZE = "16";
  };
}