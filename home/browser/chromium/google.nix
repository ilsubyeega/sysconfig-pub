{ pkgs, lib, ... }: {

  home.packages = [ (lib.setPrio 2 pkgs.chromium) ];
  # todo rename into google chromium due to duplication with ungoogled chromium.
}
