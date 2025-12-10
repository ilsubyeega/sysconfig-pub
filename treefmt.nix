{ pkgs, ... }:
{
  projectRootFile = "flake.nix";
  programs = {
    nixfmt.enable = true;
    jsonfmt.enable = true;
    yamlfmt.enable = true;
  };
}
