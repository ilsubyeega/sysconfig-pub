inputs @ { common, nixpkgs, nixpkgs-stable, nixpkgs-unstable, nixpkgs-master, nixos-generators, ... }: 
  nixos-generators.nixosGenerate rec {
    system = "x86_64-linux";
    format = "iso";

    specialArgs = {
      inherit inputs;
      pkgs-stable = import nixpkgs-stable { inherit system; config.allowUnfree = true; };
      pkgs-unstable = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };
      pkgs-master = import nixpkgs-master { inherit system; config.allowUnfree = true; };
    };

    modules = [
      common.mixins.nixos.utilities
      (import ./dummy-file.nix)
      ./configuration.nix
      {
        isoImage.isoBaseName = "ilsubyeega-sysconfig-test";
        isoImage.appendToMenuLabel = " Live CD";
        isoImage.squashfsCompression = null;
      }
    ];

  }