{ pkgs, lib, ... }: {
  home.packages = with pkgs.unstable; [

    # gcc
    (lib.setPrio 0 libgccjit)
    (lib.setPrio 2 libgcc)
    gdb

    # LLVM
    (lib.setPrio 0 llvm_17)
    (lib.setPrio 2 llvm_19)
    (lib.setPrio 0 lldb_17)
    (lib.setPrio 2 lldb_19)
    (lib.setPrio 0 lld_17)
    (lib.setPrio 2 lld_19)

    clang
    llvm-manpages
    clang-manpages

  ];
}
