{ pkgs-unstable, lib, ... }: {
  home.packages = with pkgs-unstable; [ 
    
    # JDK
    (lib.setPrio 10 jdk8)
    (lib.setPrio 8 jdk11)
    (lib.setPrio 6 jdk17)
    (lib.setPrio 2 jdk23)
    (lib.setPrio 1 jdk)
    
    gradle maven
    
    kotlin
    kotlin-native
    ktfmt
    
  ];
}