# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, unstable, master, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ../../../overlays/default.nix
    ../../../nixos/common.nix
    ../../../nixos/hardware/logitech.nix
    ../../../nixos/system/audio/pipewire.nix
    ../../../nixos/system/graphical/gnome.nix
    ../../../nixos/system/graphical/fonts.nix
    ../../../nixos/system/ime/fcitx5.nix
    ../../../nixos/system/network/cloudflare/default.nix
    ../../../nixos/system/network/wireshark.nix
    ../../../nixos/system/virtualisation.nix
    ./hardware-configuration.nix
  ];

  # FIXME: https://github.com/NixOS/nixpkgs/issues/330685
  #boot.kernelPackages = pkgs.master.linuxPackages;
  boot.blacklistedKernelModules = [ "hid_nintendo" ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "root" "@wheel" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    #useOSProber = true;
    efiSupport = true;
    timeoutStyle = "hidden";
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  networking.hostName = "laptop-t14"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Seoul";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ko_KR.UTF-8";
    LC_IDENTIFICATION = "ko_KR.UTF-8";
    LC_MEASUREMENT = "ko_KR.UTF-8";
    LC_MONETARY = "ko_KR.UTF-8";
    LC_NAME = "ko_KR.UTF-8";
    LC_NUMERIC = "ko_KR.UTF-8";
    LC_PAPER = "ko_KR.UTF-8";
    LC_TELEPHONE = "ko_KR.UTF-8";
    LC_TIME = "ko_KR.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sob = {
    isNormalUser = true;
    description = "ilsubyeega";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "kvm"
      "docker"
      "adbusers"
      "wireshark"
    ];
    packages = with pkgs;
      [
        #  thunderbird
      ];
  };

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    git

    bluez
    bluez-tools
    usbutils
    hexdump

    heroic
  ];

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    config.credential.helper = "libsecret";
  };
  programs.nh = {
    enable = true;
    flake = "/home/sob/sysconfig";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.fwupd.enable = true;

  services.logind.lidSwitchExternalPower = "ignore";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;

  hardware.opengl = rec {
    enable = true;
    extraPackages = with pkgs; [ mesa intel-media-sdk libvdpau-va-gl ];
    extraPackages32 = extraPackages;
    driSupport = true;
    driSupport32Bit = true;
  };
  hardware.intel-gpu-tools.enable = true;
  hardware.opentabletdriver.enable = true;
  # use wayland for gaming.
  environment.sessionVariables.SDL_VIDEODRIVER = "wayland";

  services.tailscale.enable = true;
  services.vscode-server.enable = true;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
