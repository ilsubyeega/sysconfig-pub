{ ... }:
{
  networking.networkmanager.dns = "systemd-resolved";
  services.resolved = {
    enable = true;
    dnsovertls = "true"; # or "opportunistic"
    fallbackDns = [
      "1.1.1.1"
      "8.8.8.8"
    ];
  };
}
