{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nautilus
    gnome.gvfs
    gnome-logs
    gnome-usage
    gnome-text-editor
    gnome-photos
    gnome-bluetooth
    gnome-font-viewer
    gnome-calculator
    dconf-editor
    gnome-disk-utility
    eog # image viewer

    gnome-control-center
  ];
  services.gnome.gnome-settings-daemon.enable = true;
  services.gnome.gnome-keyring.enable = true;
  programs.nautilus-open-any-terminal.enable = true;
  programs.nautilus-open-any-terminal.terminal = "alacritty";
}
