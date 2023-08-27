{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    twemoji-color-font
  ];
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      inter
      lato
      lexend
      roboto-mono
      (nerdfonts.override {fonts = ["RobotoMono"];})
      twemoji-color-font
      fira-code
      fira-code-symbols
    ];

    # this fixes emoji stuff
    fontconfig = {
      defaultFonts = {
        monospace = [
          "Roboto Mono"
          "Roboto Mono Nerd Font Complete Mono"
          "RobotoMono Nerd Font"
          "Noto Color Emoji"
        ];
        sansSerif = ["Lexend" "Noto Color Emoji"];
        serif = ["Noto Serif" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
