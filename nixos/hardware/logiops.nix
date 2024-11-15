{ pkgs, ... }: {
  # See https://github.com/NixOS/nixpkgs/pull/287399 for nixos-wide implementation.
  environment.systemPackages = with pkgs; [ logiops ];
  systemd.services.logid = {
    enable = true;
    description = "Logitech Configuration Daemon";
    startLimitIntervalSec = 0;
    after = [ "multi-user.target" ];
    wants = [ "multi-user.target" ];
    wantedBy = [ "graphical.target" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.logiops}/bin/logid";
      User = "root";
    };
  };

  environment.etc."logid.cfg".text = ''
    devices: (
    {
      name: "MX Master 3S";
      smartshift: { on: false; threshold: 0; default_threshold: 0; };
      hiresscroll: { 
        hires: true;
        invert: false;
        target: false;

      };
      dpi: 800;
      buttons: (
      
      );
    }
    );
  '';
}
