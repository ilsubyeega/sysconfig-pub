/* - The nixpkgs(nixos-24.05) build broken, overriding to develop git branch.

   - In order to use this at GNOME environment, do following on dconf.
     Otherwise, some programs listen to the R-Alt and actually triggers it.
      `/org/gnome/desktop/input-sources/xkb-options`
      - Add ['korean:ralt_hangul'].

   - Known Issues:
      - GNOME Shell does not listen to kime, looks like they have only ibus thing.
        This require ibus frontend implementation,
          See https://github.com/Riey/kime/issues/422
*/
{ super, ... }:
with super.inputs; {
  nixpkgs.overlays = [
    (final: prev: {
      kime = prev.kime.overrideAttrs (old: rec {
        version = "git-develop";
        src = prev.fetchFromGitHub {
          owner = "Riey";
          repo = "kime";
          rev = "develop";
          hash = "sha256-kWocmaSN9kGIFyUEn96TnbNX4nPNo1ONa9gZ2b7MegY=";
        };
        cargoDeps = prev.rustPlatform.fetchCargoTarball {
          inherit src;
          hash = "sha256-2MG6xigiKdvQX8PR457d6AXswTRPRJBPERvZqemjv24=";
        };
      });
    })
  ];
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enable = true;
      type = "kime";
      kime.extraConfig = ''
        engine:
          global_hotkeys:
            AltR:
              behavior: !Toggle
                - Hangul
                - Latin
              result: Consume
            Hangul:
              behavior: !Toggle
                - Hangul
                - Latin
              result: Consume
      '';
    };
  };
}
