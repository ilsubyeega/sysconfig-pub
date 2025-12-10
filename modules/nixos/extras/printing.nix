{ pkgs, ... }:
{
  services.printing = {
    enable = true;
    drivers = with pkgs; [ samsung-unified-linux-driver ];
  };
  # Autodiscovery of network printers.
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  services.ipp-usb.enable = true;
  environment.systemPackages = with pkgs; [ ipp-usb ];
}
