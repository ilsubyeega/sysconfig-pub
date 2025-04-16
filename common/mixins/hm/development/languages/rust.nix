{ pkgs-unstable, ... }: {
  home.packages = with pkgs-unstable; [ 
    rustc
    cargo
    rust-analyzer
    clippy
    rust-bindgen
  ];
}