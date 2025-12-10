{
  inputs,
  lib,
  pkgs,
  pkgs-master,
  ...
}:
{
  imports = [
    ../../modules/hm-common/default.nix
    ../../modules/hm-dev/default.nix
  ];

  home = {
    stateVersion = "25.05";
    enableDebugInfo = true;
    sessionVariables = {

    };
  };

}
