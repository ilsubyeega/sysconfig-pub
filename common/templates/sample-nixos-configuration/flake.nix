{
  description = "sysconfig template";

  outputs = inputs @ { nixpkgs, ... }: let 
  
    # nixos configuration에서 nixpkgs-stable, unstable, master 등록.
  in {
    nixosConfigurations.test = (import ./host.nix inputs);

    packages.x86_64-linux = {
      iso = (import ./iso.nix inputs);
    };
  };

  inputs = {
    nixpkgs.follows = "nixpkgs-stable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/release-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";

    # Flake not accessible through symlink: https://github.com/NixOS/nix/issues/8013
    common = {
      url = "/home/sob/projects/ilsubyeega/sysconfig/common"; # todo: move this
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
  };
}