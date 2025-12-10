{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    #inputs.determinate.nixosModules.default
    inputs.chaotic.nixosModules.default
  ];
  nixpkgs.overlays = [
    inputs.nix-alien.overlays.default
    inputs.frida-nix.overlays.default
  ];
  nix = {
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = "nix-command flakes";
      trusted-public-keys = [
        #"cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      substituters = [
        #"https://install.determinate.systems"
      ];

      # https://determinate.systems/posts/changelog-determinate-nix-352/
      #lazy-trees = true;
    };
  };
  programs.nh.enable = true;
  programs.nh.flake = lib.mkDefault "/infra/personal";
  programs.nix-ld.enable = true;
  environment.sessionVariables.NH_OS_FLAKE = lib.mkDefault "/infra/personal";
  environment.systemPackages = with pkgs; [
    cachix
    nix-alien
    nix-index
    attic-client
  ];
  system.stateVersion = lib.mkDefault "25.05";
}
