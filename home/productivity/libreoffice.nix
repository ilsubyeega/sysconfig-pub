{ pkgs, ... }:
let libreoffice = pkgs.libreoffice;
in {

  # still: most stable, fresh: unstable, but most active development.
  home.packages = [
    libreoffice
    pkgs.hunspell
    #pkgs.hunspell.ko_KR <-- not exists.
  ];

  home.sessionVariables = {
    PYTHONPATH = "${libreoffice}/lib/libreoffice/program";
    URE_BOOTSTRAP =
      "vnd.sun.star.pathname:${libreoffice}/lib/libreoffice/program/fundamentalrc";
  };

}
