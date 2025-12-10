{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # for saving git credentials etc. may require `gnome-keyring`.
    libsecret

    # systemd fd helper.
    systemfd
  ];

  # while some dumbhead requires to use stateful config directory (no home-manager)
  systemd.tmpfiles.rules = [
    "L /etc/brave/policies/managed - - - - /infra/personal/configs/browser/brave/policies-managed"
  ];
}
