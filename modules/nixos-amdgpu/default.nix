{ pkgs, pkgs-unstable, ... }:
{
  hardware.amdgpu = {
    initrd.enable = false;
    opencl.enable = true;
    #amdvlk = {
    #  enable = true;
    #  support32Bit.enable = true;
    #  package = pkgs-unstable.amdvlk;
    #};
  };
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      libva
      vaapiVdpau
      libvdpau-va-gl
      #pkgs-unstable.mesa
      #pkgs-unstable.amdvlk
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      vaapiVdpau
      libvdpau-va-gl
      #pkgs-unstable.mesa
      #pkgs-unstable.amdvlk
    ];
  };
}
