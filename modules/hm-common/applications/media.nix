{ pkgs, pkgs-unstable, ... }:
{
  home.packages = with pkgs; [
    # Player
    pkgs-unstable.spotify
    mpv
    vlc
    celluloid

    # tools
    gimp3
    inkscape
    krita
    blender
    kdePackages.kdenlive
    musescore

    pkgs-unstable.obs-studio
    pkgs-unstable.obs-studio-plugins.obs-vaapi
    pkgs-unstable.obs-studio-plugins.obs-gstreamer
    pkgs-unstable.obs-studio-plugins.obs-pipewire-audio-capture
  ];
}
