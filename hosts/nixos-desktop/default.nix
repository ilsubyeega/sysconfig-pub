inputs@{ ... }:
let
  system = "x86_64-linux";
  extraInputs = with inputs; {
    pkgs-master = import nixpkgs-master {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  };
in
inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = {
    inherit inputs;
  }
  // extraInputs;

  modules = [
    {
      nixpkgs.overlays = [
        inputs.niri.overlays.niri
      ];
    }
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ]
  ++ [
    ./nixos.nix
    ./hardware-configuration.nix
    {
      home-manager = {
        users.sob = (import ./home.nix);
        extraSpecialArgs = {
          inherit inputs;
        }
        // extraInputs;
      };
    }
  ];
}
