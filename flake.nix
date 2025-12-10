{
  description = "Personal NixOS 25.05 Configuration";

  outputs =
    {
      nixpkgs,
      treefmt-nix,
      systems,
      self,
      ...
    }@inputs:
    let
      helper = import ./helper.nix { lib = nixpkgs.lib; };
      treefmt = helper.initTreefmt inputs;

      finalArgs = inputs;
    in
    {
      nixosConfigurations = {
        desktop = (import ./hosts/nixos-desktop/default.nix finalArgs);
        t14 = (import ./hosts/nixos-t14/default.nix finalArgs);
      };
    }
    // treefmt;

  inputs = {
    #determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";

    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    hm = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # alternative packages repo
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    # Formatter
    treefmt-nix.url = "github:numtide/treefmt-nix";
    # Secret management
    sops-nix.url = "github:Mic92/sops-nix";

    # Niri, the wayland compositor
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };
    #niri.inputs.niri-unstable.url = "github:YaLTeR/niri/5edd91d37b25a751880d3a7bd3b92f0016d0cdc4";

    #
    nix-alien.url = "github:thiagokokada/nix-alien";

    # dev
    frida-nix = {
      url = "github:ilsubyeega/frida-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
