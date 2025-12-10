{
  config,
  pkgs,
  pkgs-unstable,
  inputs,
  lib,
  ...
}:

{
  imports = [
    ../../modules/nix-setup/nixos.nix
    ../../modules/nixos/extras/wireshark.nix
    ../../modules/nixos/default.nix
    ../../modules/nixos-fde/default.nix
    ../../modules/nixos-amdgpu/default.nix
    ../../modules/nixos-applications/default.nix

    ../../modules/nixos-services/flatpak.nix
    ../../modules/nixos-services/pipewire.nix
    ../../modules/nixos-services/power.nix
    ../../modules/nixos-services/sunshine.nix
    ../../modules/nixos-services/dev.nix

    ../../modules/nixos-de-niri/default.nix
  ];

  modules = {
    nixos = {
      gaming = {
        steam = true;
        compat = true;
        osu = true;
        minecraft = true;
      };
      hardware.bluetooth = true;
      virtualisation = {
        virt-manager = true;
        waydroid = true;
        containers = true;
      };
    };
  };

  #boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.blacklistedKernelModules = [ "cdc_acm" ];
  boot.kernelParams = [
    "ip=dhcp"
    "usbcore.autosuspend=-1"
  ];
  networking = {
    hostName = "desktop";
    firewall.enable = false;

    modemmanager.enable = false;
  };

  users.users.sob = {
    isNormalUser = true;
    description = "sob";
    extraGroups = [
      "root"
      "networkmanager"
      "wheel"
      "libvirtd"
      "kvm"
      "docker"
      "adbusers"
      "wireshark"
      "podman"
      "input"
    ];
  };

  hardware = {

  };

  environment = {
    # use `nix search pkg` for searching
    systemPackages = with pkgs; [
      wget
      curl
    ];
    enableDebugInfo = true;
    pathsToLink = [
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];
  };

  #services = {
  #  ollama = {
  #    enable = true;
  #    package = pkgs-unstable.ollama-rocm;
  #  };
  #};

  system.stateVersion = "25.05";
  nixpkgs.config.allowUnfree = true;
}
