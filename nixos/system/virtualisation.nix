{ pkgs, ... }: {
  # https://nixos.wiki/wiki/Virt-manager
  programs.virt-manager.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };
  #virtualisation.libvirtd.package = pkgs.master.libvirt;
  #virtualisation.libvirtd.qemu.package = pkgs.master.qemu;
  virtualisation.lxc.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  virtualisation.waydroid.enable = true;
  
  environment.systemPackages = with pkgs; [
    # podman stuffs
    dive
    podman-tui
    podman-compose

    # vm
    virtiofsd

    # waydroid
    wl-clipboard
  ];


}
