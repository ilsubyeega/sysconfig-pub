{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.nixos.fonts;
in
{
  options.modules.nixos.fonts = lib.mkOption {
    default = true;
    type = lib.types.bool;
  };
  config = lib.mkIf cfg {
    fonts = {
      fontDir = {
        enable = true;
        decompressFonts = true;
      };

      enableDefaultPackages = true;
      fontconfig = {
        enable = true;
        antialias = true;
        subpixel.rgba = "rgb";
        defaultFonts = {
          serif = [
            "Noto Serif"
            "Noto Serif CJK KR"
            "Pretendard"
            "Pretendard JP"
            "DejaVu Serif"
            "D2CodingLigature Nerd Font"

            "Font Awesome Free"
          ];
          sansSerif = [
            "Noto Sans"
            "Noto Sans CJK KR"
            "Pretendard"
            "Pretendard JP"
            "DejaVu Serif"
            "D2CodingLigature Nerd Font"

            "Font Awesome Free"
          ];
          monospace = [
            "Noto Sans Mono"
            "Noto Sans Mono CJK KR"
            "D2CodingLigature Nerd Font Mono"
            "DejaVu Serif"
            "Font Awesome Free"
          ];
          emoji = [
            "Noto Color Emoji"
            "Noto Emoji"
            "Twitter Color Emoji"
            "Font Awesome Free"
          ];
        };
      };
      packages = with pkgs; [
        pretendard
        pretendard-jp
        pretendard-std
        pretendard-gov

        twemoji-color-font
        noto-fonts
        noto-fonts-cjk-serif
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        noto-fonts-emoji-blob-bin
        noto-fonts-monochrome-emoji
        twitter-color-emoji

        font-awesome
        nerd-fonts.d2coding # Korean coding fonts.
        nerd-fonts.fira-code
        nerd-fonts.roboto-mono
        nerd-fonts.noto
        nerd-fonts.droid-sans-mono
      ];
    };
  };
}
