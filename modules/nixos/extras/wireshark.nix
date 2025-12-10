{ pkgs, lib, ... }:
{
  programs.wireshark = {
    enable = true;
    dumpcap.enable = true;
    usbmon.enable = true;
  };

  environment.systemPackages = [ pkgs.wireshark ];
  users.groups.wireshark = lib.mkDefault { };
  users.users.sob.extraGroups = [ "wireshark" ];
}
