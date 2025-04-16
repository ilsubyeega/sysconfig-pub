inputs @ { common, nixpkgs, nixpkgs-stable, nixpkgs-unstable, nixpkgs-master, ... }: 
  nixpkgs.lib.nixosSystem rec {
    system = "x86_64-linux";

    specialArgs = {
      inherit inputs;
      pkgs-stable = import nixpkgs-stable { inherit system; config.allowUnfree = true; };
      pkgs-unstable = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };
      pkgs-master = import nixpkgs-master { inherit system; config.allowUnfree = true; };
    };

    modules = [
      common.mixins.nixos.utilities
      ./configuration.nix
      ./hardware-configuration.nix
    ];
  }