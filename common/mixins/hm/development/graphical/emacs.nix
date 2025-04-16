{ pkgs, ... }: {
  programs.emacs = {
    enable = true;
    # Overrides the emacs package to add a wrapper that unsets XMODIFIERS
    package = pkgs.symlinkJoin {
      inherit (pkgs.emacs) version;
      name = "emacs-wrapped";
      nativeBuildInputs = [ pkgs.makeWrapper ];
      paths = [ pkgs.emacs ];
      postBuild = ''
        wrapProgram $out/bin/emacs --set XMODIFIERS=none
      '';
    };
  };
}
