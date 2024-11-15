{
  description = "fuck my nix(os/on-droid, home-manager) configration";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    #extra-trusted-public-keys = [];
  };

  inputs = {
    # nixpkgs
    nixpkgs.follows = "nixpkgs-stable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";

    # main utilities
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # misc
    treefmt-nix.url = "github:numtide/treefmt-nix";
    nixos-vscode-server.url = "github:nix-community/nixos-vscode-server";

    # linux 6.6.44 broken, reverting into 6.6.43 at htis moment
    nixpkgs-stable-locked.url =
      "github:nixos/nixpkgs?rev=1d9c2c9b3e71b9ee663d11c5d298727dace8d374";
    # testing purpose
  };

  outputs = inputs@{ ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      # debug = true;
      systems = [ "x86_64-linux" "aarch64-linux" ];
      imports = [ ./lib/formatter.nix ./hosts ];
    };
}
