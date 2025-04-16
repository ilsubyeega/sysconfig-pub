{
  description = "ilsubyeega/sys-common";

  outputs = inputs@{ nixpkgs, ...}: let
    utils = import ./utils.nix { lib = nixpkgs.lib; };
  in {
    lib.utils = utils;
    mixins = utils.makeDirImportAttr ./mixins;
    profiles = utils.makeDirImportAttr ./profiles;

    # todo: work shells, packages.
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };
}
