{ pkgs, ... }: {
  home.packages = with pkgs.unstable; [
    rustc
    cargo
    rust-analyzer-unwrapped
    clippy
    rust-bindgen-unwrapped
  ];
}
