{ pkgs, pkgs-unstable, ... }:
{
  programs.git = {
    enable = true;
    userName = "ilsubyeega";
    userEmail = "git@fmt.kr";
    package = pkgs.gitFull;
    extraConfig = {
      # requires libsecret package.
      credential.helper = "libsecret";
    };
  };
  programs.jujutsu = {
    enable = true;
    package = pkgs-unstable.jujutsu;
    # todo: credential?
  };

  home.packages = with pkgs-unstable; [
    gh
    jujutsu
    jjui
  ];
}
