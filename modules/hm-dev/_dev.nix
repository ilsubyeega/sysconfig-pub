{
  lib,
  pkgs,
  pkgs-master,
  ...
}:
rec {

  languages = {
    c = with pkgs; [
      # gcc
      (lib.setPrio 0 libgccjit)
      (lib.setPrio 2 libgcc)
      (lib.setPrio 0 gdb)

      # LLVM
      (lib.setPrio 0 llvm_17)
      (lib.setPrio 0 lldb_17)
      (lib.setPrio 0 lld_17)

      (lib.setPrio 2 llvm_19)
      (lib.setPrio 2 lldb_19)
      (lib.setPrio 2 lld_19)

      clang
      llvm-manpages
      clang-manpages
      rr
    ];
    rust = with pkgs; [
      rustc
      cargo
      rust-analyzer
      clippy
      rust-bindgen
      rustfmt
    ];
    nix = with pkgs; [
      nixd
      nil
      nix-du
      nix-tree
      nh # nix-helper
    ];
    javascript = with pkgs; [
      (lib.setPrio 0 nodejs_24)
      (lib.setPrio 6 nodejs_22)
      (lib.setPrio 8 nodejs_20)

      pnpm
      yarn-berry
      typescript

      deno
      bun
    ];
    jvm = with pkgs; [
      (lib.setPrio 10 jdk8)
      (lib.setPrio 8 jdk11)
      (lib.setPrio 6 jdk17)
      (lib.setPrio 2 jdk23)
      (lib.setPrio 1 jdk)

      gradle
      maven

      kotlin
      kotlin-native
      ktfmt
    ];
    python = with pkgs; [
      (lib.setPrio 0 python312Full)
      (lib.setPrio 2 python313Full)
      (lib.setPrio 10 jupyter-all)

      conda
      virtualenv
      poetry
      uv
    ];
    go = with pkgs; [ go ];
    lua = with pkgs; [ luajit ];
    typst = with pkgs; [
      typst
      tinymist
    ];
  };

  languages-all = lib.lists.flatten (lib.attrsets.attrValues languages);
}
