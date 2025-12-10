{ pkgs, ... }:
{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    #jack.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    pwvucontrol
    easyeffects
    helvum
    coppwr
  ];

  # FIXME: Low latency setuo makes sound suck.

}
