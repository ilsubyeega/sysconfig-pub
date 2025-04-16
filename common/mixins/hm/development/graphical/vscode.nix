{ pkgs, pkgs-master, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs-master.vscode.fhs; # use master
    
    extensions = with pkgs-master.vscode-extensions; [
      github.copilot
      github.copilot-chat
    ];

    # do configure a user settings manually; immutable does not work well here.
  };
}
