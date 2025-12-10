{
  lib,
  config,
  pkgs-unstable,
  ...
}:
let
  cfg = config.modules.nixos.network;
in
{
  options.modules.nixos.network = lib.mkOption {
    default = true;
    type = lib.types.bool;
  };
  config = lib.mkIf cfg {
    networking.networkmanager.enable = true;
    networking.nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];

    networking.timeServers = [
      # KR Specific
      "time.bora.net"
      "time2.kriss.re.kr"
      "ntp.kornet.net"

      # Others
      #"time.google.com"
      #"time1.google.com"
      #"time2.google.com"
      #"time3.google.com"
      #"time4.google.com"
      #"time.aws.com"
      #"time.cloudflare.com"
      #"time.windows.com"
      #"time.apple.com"
      #"time.nist.gov"
    ];
    # NTP daemon
    services.chrony.enable = true;
    networking.dhcpcd.wait = "background";

    networking.wireguard.enable = true;
    programs.openvpn3.enable = true;
    services.tailscale.package = pkgs-unstable.tailscale;
    services.tailscale.enable = true;
  };
}
