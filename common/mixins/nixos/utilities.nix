{ pkgs, ... } : {
  # essential utilities
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    whois
    moreutils
    htop
    
    # extra
    dig # nslookup
    jq

    # gui
    d-spy
  ];
}
