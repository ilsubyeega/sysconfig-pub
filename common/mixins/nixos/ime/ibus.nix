{ pkgs, ... }: {
  i18n.inputMethod = {
    enable = true;
    type = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ hangul ];
  };
  environment.systemPackages = [ pkgs.ibus-engines.hangul ];
}
# *FIXME
# need to manually add "Hangul" layout.
# no idea how to set change locales using "Hangul" or "Right+Alt" keyboard, it only available with "Shift+SPACE."
