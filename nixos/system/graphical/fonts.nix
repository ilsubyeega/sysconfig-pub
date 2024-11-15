{ pkgs, lib, ... }: {
  fonts.packages = with pkgs; [
    pretendard
    # includes: ibm-plex jetbrains-mono nanum nanum-gothic-coding inter
    google-fonts
    twemoji-color-font
    noto-fonts-cjk-serif
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    noto-fonts-emoji-blob-bin
    noto-fonts-monochrome-emoji
    source-sans
    source-sans-pro
    source-serif
    source-han-sans
    source-han-mono
    source-code-pro
    source-serif-pro
    source-han-serif
    source-han-code-jp
    source-han-sans-vf-ttf
    source-han-sans-vf-ttf
    source-han-serif-vf-otf
    source-han-serif-vf-otf
  ];
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "Noto Serif CJK KR" "Noto Serif" "DejaVu Serif" ];
      sansSerif = [ "Noto Sans CJK KR" "Noto Sans" "DejaVu Serif" ];
      monospace = [ "Noto Sans Mono CJK KR" "Noto Sans Mono" "Noto Sans Mono" ];
      emoji = [ "Noto Color Emoji" "Noto Emoji" ];
    };
  };
  programs.dconf.profiles.gdm.databases = [{
    settings = {
      "org/gnome/desktop/interface" = {
        "font-name" = "Noto Sans CJK KR 11 @wght=400";
        "document-font-name" = "Noto Serif CJK KR 12 @wght=400";
        "monospace-font-name" = "Noto Sans Mono CJK KR 12";
      };
    };
  }];
}
