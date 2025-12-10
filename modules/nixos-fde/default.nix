# The configuration of FDE(Full Disk Encryption)
{ ... }:
{
  config = {
    boot.initrd = {
      enable = true;
      verbose = true;
      network = {
        enable = true;
        flushBeforeStage2 = true;
        ssh = {
          enable = true;
          port = 19722;
          authorizedKeyFiles = [
            ./ssh_host_rsa_key.pub
          ];
          hostKeys = [
            ./ssh_host_rsa_key
          ];
        };
      };
      systemd = {
        enable = true;
        emergencyAccess = true;
        extraConfig = ''
          DefaultDeviceTimeoutSec=infinity
        '';
      };
    };
    services.openssh.enable = true;
  };
}
