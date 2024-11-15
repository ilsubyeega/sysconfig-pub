/* - Setup:
    - At `Input Method > Available Input Method`, search hangul then select Hangul.
    - Check `Global Options > Trigger Input Method`, that `Hangul` exists.
    - if you have GNOME SHELL do following on dconf:
      `/org/gnome/desktop/input-sources/xkb-options`
      - Add ['korean:ralt_hangul'].
*/
{ pkgs, ... }: {
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [ fcitx5-mozc fcitx5-gtk fcitx5-hangul ];
      };
    };
  };
}
