{
  pkgs,
  pkgs-unstable,
  pkgs-master,
  ...
}:
{
  home.packages = with pkgs-unstable; [
    pkgs-master.figma-agent
    #figma-linux
  ];
}
