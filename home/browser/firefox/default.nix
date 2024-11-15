{ pkgs, lib, ... }: {

  home.packages = [ (lib.setPrio 0 pkgs.unstable.firefox) ];
  # set MOZ_USE_XINPUT2=1 ?
}
