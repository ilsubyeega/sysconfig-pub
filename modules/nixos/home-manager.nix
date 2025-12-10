{ inputs, ... }:
let
  homeManagerSessionVars = "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh";
in
{
  imports = [ inputs.hm.nixosModules.default ];
  home-manager = {
    backupFileExtension = "bak";
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  # workarounds for https://github.com/nix-community/home-manager/issues/1011
  environment.extraInit = "[[ -f ${homeManagerSessionVars} ]] && source ${homeManagerSessionVars}";
}
