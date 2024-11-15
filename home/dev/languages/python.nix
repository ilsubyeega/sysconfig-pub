{ pkgs, lib, ... }: {
  home.packages = with pkgs.unstable; [
    (lib.setPrio 0 python312Full)
    (lib.setPrio 2 python313Full)
    (lib.setPrio 10 python39Full)

    conda
    virtualenv
    poetry
  ];
}
