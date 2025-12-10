{ pkgs-unstable, ... }:
{
  programs.ccache.enable = true;
  environment.systemPackages = with pkgs-unstable; [
    ccache
    sccache
  ];
}
