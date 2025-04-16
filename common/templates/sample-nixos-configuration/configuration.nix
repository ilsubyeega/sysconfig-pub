{ pkgs, lib, ... }: {

  boot = {
    blacklistedKernelModules = [];

    loader = {
      grub = {
        enable = lib.mkDefault true;
        device = "nodev";
        timeoutStyle = "hidden";
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
  };

  networking = {
    hostName = "sysconfig-test";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };

  users.users = {
    # configure this.
    nixos = {
      isNormalUser = true;
      initialPassword = "nixos";
      description = "Default NixOS User";
      extraGroups = [ "wheel" "networkmanager" ];
    };
  };

  environment = {
    systemPackages = with pkgs; [ vim wget curl git ];
  };

  services = {
    openssh.enable = true;
  };

  system = {
    stateVersion = "24.05";
  };
}