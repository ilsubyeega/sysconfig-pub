{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ fuzzel ];
  environment.sessionVariables."TERMINAL" = "alacritty";
}
