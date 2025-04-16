{ ... }: {
  networking.nameservers = [
    # cloudflare ipv4 and ipv6 dns
    "1.1.1.1"
    "1.0.0.1"
    "2606:4700:4700::1111"
    "2606:4700:4700::1001"
    
    # google ipv4 and ipv6 dns
    "8.8.8.8"
    "8.8.4.4"
  ];
  
  networking.timeServers = [
    "ntp.kornet.net"
    "ntp2.kornet.net"
    "time.cloudflare.com"
    "time.google.com"
  ];
}