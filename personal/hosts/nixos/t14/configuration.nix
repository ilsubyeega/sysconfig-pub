{ pkgs, pkgs-master, lib, pkgs-2405, ... }: {

  boot = {
    #kernelPackages = pkgs.linuxKernel.packages.linux_6_12; # lts.
    blacklistedKernelModules = [ "libwacom" ];

    kernel.sysctl = {
      "vm.vfs_cache_pressure" = 1; # 많으면 역효과
      "vm.swappiness" = 1;
      "vm.dirty_background_ratio" = 10;
      "vm.dirty_expire_centisecs" = 1000;
    };

    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        timeoutStyle = "hidden";
      };
      systemd-boot.enable = false;
      efi = {
        canTouchEfiVariables = true;
      };

      timeout = 0;
    };

  };

  networking = {
    hostName = "t14";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  time.timeZone = "Asia/Seoul";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = rec {
      LC_NAME = "ko_KR.UTF-8";
      LC_ADDRESS = LC_NAME;
      LC_IDENTIFICATION = LC_NAME;
      LC_MEASUREMENT = LC_NAME;
      LC_MONETARY = LC_NAME;
      LC_NUMERIC = LC_NAME;
      LC_PAPER = LC_NAME;
      LC_TELEPHONE = LC_NAME;
      LC_TIME = LC_NAME;
    };
  };

  users.users = {
    # configure this.
    sob = {
      isNormalUser = true;
      description = "Il Sub Shin";
      extraGroups = [ "root" "wheel" "networkmanager" "libvirtd" "kvm" "docker" "adbusers" "wireshark" "podman" ];
    };
  };

  environment = {
    systemPackages = with pkgs; [ gparted fuse3 gdb ];
    variables = {
      # Enable unfree packages for nix-shell
      "NIXPKGS_ALLOW_UNFREE" = "1";
      "KWIN_DRM_DISABLE_TRIPLE_BUFFERING" = "1"; # https://bugs.kde.org/show_bug.cgi?id=488860
    };
    sessionVariables = {
      #"NIXOS_OZONE_WL" = "1";
      #"MOZ_ENABLE_WAYLAND" = "1";
    };
    enableDebugInfo = true;
    
    # testing
    #stub-ld.enable = true;
  };

  services = {
    openssh.enable = true;
    # enable it after FDE.
    #displayManager.autoLogin = {
    #  enable = true;
    #  user = "sob";
    #};

    fwupd.enable = true;
    sysprof.enable = true;
    
    hardware.bolt.enable = true;
    
    flatpak.enable = true;
    
    # debugging
    nixseparatedebuginfod.enable = true;
    
  };

  programs = {
    kdeconnect.enable = true;
    dconf.enable = true;
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "@wheel" ];
  };

  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };

  hardware = {
    bluetooth.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs;
      [
        intel-media-driver
        intel-media-sdk
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ intel-vaapi-driver ];
    };
    opentabletdriver = {
      enable = true;
      #package = pkgs-master.opentabletdriver;
      daemon.enable = true;
    };
    enableAllFirmware = true;
  };

  system = {
    stateVersion = "24.11";
  };
}
