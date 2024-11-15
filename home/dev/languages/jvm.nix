{ pkgs, lib, ... }: {
  home.packages = with pkgs.unstable; [
    # JDK
    (lib.setPrio 4 jdk8)
    (lib.setPrio 8 jdk11)
    (lib.setPrio 6 jdk17)
    #(lib.setPrio 2 jdk22) EOL
    (lib.setPrio 0 jdk) # currently 21

    gradle
    maven

    # Kotlin
    kotlin
    kotlin-native
    # Kotlin Community
    kotlin-language-server
    ktfmt
  ];
}
