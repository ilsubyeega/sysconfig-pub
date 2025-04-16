{
  description = "ilsubyeega's sysconfig";

  outputs = inputs @ { nixpkgs, ... }: let
    # todo
  in {
    nixosConfigurations.t14 = (import ./hosts/nixos/t14/default.nix inputs);
  };

  inputs = {
    nixpkgs.follows = "nixpkgs-stable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    #nixpkgs-2405.url = "github:nixos/nixpkgs/nixos-24.05";

    #nixpkgs-temp.url = "github:nixos/nixpkgs/6efb622aca97c5bdf051f9bf554b2fc9a958d07e";
    # https://github.com/NixOS/nixpkgs/commits/nixos-24.11/pkgs/development/libraries/mesa/common.nix

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-stable";

    # Flake not accessible through symlink: https://github.com/NixOS/nix/issues/8013
    common = {
      url = "/home/sob/sysconfig/common"; # todo: move this
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
  };
}
