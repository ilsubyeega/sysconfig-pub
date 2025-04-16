inputs @ { common, nixpkgs-stable, nixos-hardware, home-manager, ... }: let
  system = "x86_64-linux";
  extraInputs = with inputs; {
    pkgs-stable = import nixpkgs-stable { inherit system; config.allowUnfree = true; };
    pkgs-unstable = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };
    pkgs-master = import nixpkgs-master { inherit system; config.allowUnfree = true; };
    #pkgs-2405 = import nixpkgs-2405 { inherit system; config.allowUnfree = true; };
    #pkgs-temp = import nixpkgs-temp { inherit system; config.allowUnfree = true; };
  };

  in
  nixpkgs-stable.lib.nixosSystem rec {
    inherit system;

    specialArgs = {
      inherit inputs;
    } // extraInputs;

    modules = [
      common.mixins.nixos.audio.pipewire
      common.mixins.nixos.audio.easyeffects
      
      common.mixins.nixos.graphical.plasma6
      common.mixins.nixos.graphical.fonts
      common.mixins.nixos.ime.fcitx5

      common.mixins.nixos.network.dns
      
      common.mixins.nixos.network.tailscale
      common.mixins.nixos.network.wireguard
      common.mixins.nixos.network.wireshark
      
      common.mixins.nixos.network.nordvpn

      common.mixins.nixos.virtualisation.docker
      common.mixins.nixos.virtualisation.podman
      common.mixins.nixos.virtualisation.virt-manager

      common.mixins.nixos.nix-ld
      common.mixins.nixos.plymouth
      common.mixins.nixos.utilities
      common.mixins.nixos.input-remapper
      
      common.mixins.nixos.deploy.database

      ./configuration.nix
      ./hardware-configuration.nix

      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.sob = (import ./home.nix);
          extraSpecialArgs = { inherit inputs; } // extraInputs;
        };
      }

      nixos-hardware.nixosModules.common-cpu-intel
      nixos-hardware.nixosModules.lenovo-thinkpad-t14
    ];
  }
