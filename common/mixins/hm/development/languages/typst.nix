{ pkgs-unstable, ... }: {
  home.packages = with pkgs-unstable; [ typst tinymist ];
}
