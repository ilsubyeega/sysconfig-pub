{ inputs, ... }@super:
with inputs; {
  flake.nixosConfigurations."laptop-t14" = nixpkgs.lib.nixosSystem {

    system = "x86_64-linux";
    modules = [
      ./configuration.nix
      nixos-vscode-server.nixosModules.default
      nixos-hardware.nixosModules.common-cpu-intel # gpu included
      nixos-hardware.nixosModules.lenovo-thinkpad-t14

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.sob = import ./home.nix;
        home-manager.extraSpecialArgs = { inherit super; };
      }
    ];

    specialArgs = { inherit super; };

  };
}
