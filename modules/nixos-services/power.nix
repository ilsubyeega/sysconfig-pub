{
  services = {
    # power-sync-daemon
    psd = {
      enable = true;
      resyncTimer = "10m";
    };

    logind = {
      powerKey = "suspend";
      lidSwitch = "suspend";
      lidSwitchExternalPower = "ignore";
    };

    power-profiles-daemon.enable = true;

    # battery info
    upower = {
      enable = true;
      percentageLow = 30;
      percentageCritical = 20;
      percentageAction = 10;
      criticalPowerAction = "Hibernate";
    };
  };
}
