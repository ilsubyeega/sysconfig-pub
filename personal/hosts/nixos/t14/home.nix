{ inputs, lib, ... }:
{
  home.stateVersion = "24.11";
  imports = let
    items = with inputs.common.profiles; [
      minimal.minimal.hm
      graphical.full.hm
      extra.development.hm
    ];
    in lib.lists.flatten (map (item: (item inputs.common.mixins.hm)) items) ++
    (with inputs.common.mixins.hm; [
      graphical.desktop.plasma6
      graphical.desktop.gnome-no-de # plasma is not rich atm
      graphical.applications.game.moonlight
      graphical.applications.game.osu-lazer
      graphical.applications.utilities.parsec
    ]) ++ [
      ../../../mixins/hm/main.nix
      ../../../mixins/hm/rclone.nix
    ];
}
