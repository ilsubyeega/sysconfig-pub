{ pkgs, ... }: {
  home.packages = with pkgs.unstable;
    [
      android-tools
      agi # Android Graphic Inspector
      bytecode-viewer # decompiler with apk support
      apktool
      dex2jar
      apksigcopier
      apksigner
    ] ++ [ pkgs.master.scrcpy ];
}
