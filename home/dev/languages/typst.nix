{ pkgs, ... }: {
  home.packages = with pkgs.unstable; [ typst typst-lsp tinymist ];
}
