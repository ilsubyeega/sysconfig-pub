{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.master.vscode.fhs;
    enableUpdateCheck = false;
    
    # FIXME: this isn't mutable so BROKEN since vscode requires mutable one.
    userSettings = {
      "window.titleBarStyle" = "custom";
      "files.autoSave" = "afterDelay";
      "editor.cursorSmoothCaretAnimation" = "on";
      "cSpell.enabled" = "true";
    };
  };
}
