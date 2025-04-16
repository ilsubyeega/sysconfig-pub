# inherits from mixins/nixos/...

{ pkgs, ... }: { 
  
  home.packages = with pkgs; [
    gnome-logs
    gnome-solanum
    gnome-terminal
  ];
  
  #programs.gnome-terminal.enable = true;
  
}
