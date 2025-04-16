{ pkgs, ... }: {
  home.packages = with pkgs; [
    nixd
    nil
    nixci
    direnv
    nix-du
    devenv
    nix-tree
    nixpkgs-review

    nix-index
    
    # building configuration debug etc.
    nix-output-monitor
    nvd
  ];
}
