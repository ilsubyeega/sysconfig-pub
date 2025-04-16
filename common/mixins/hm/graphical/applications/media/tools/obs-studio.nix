{ pkgs, ... }: {

  home.packages = [ pkgs.obs-studio ] ++ (with pkgs.obs-studio-plugins; [
    obs-vaapi
    obs-gstreamer
    obs-pipewire-audio-capture
  ]);

}
