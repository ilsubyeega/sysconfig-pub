{ pkgs, ... }: {
  home.packages = with pkgs.unstable; [
    nixd
    nil
    nixci
    direnv
    nix-du
    devenv
    nix-tree
    nixpkgs-review

    nix-index

  ];
}
