{ pkgs, ... }: {
  programs.virt-manager.enable = true;
  
  virtualisation.libvirtd = {
    enable =  true;
    qemu.vhostUserPackages = [ pkgs.virtiofsd ];
  };
  
  virtualisation.lxc.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  
  environment.systemPackages = with pkgs; [
    virtiofsd # shared file system written in rust
  ];
}