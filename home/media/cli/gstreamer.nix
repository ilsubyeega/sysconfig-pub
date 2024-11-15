{ pkgs, ... }: {

  home.packages = with pkgs.unstable.gst_all_1; [
    gstreamer
    gst-plugins-base
    gst-plugins-good
    gst-plugins-bad
    gst-libav
    gst-vaapi
  ];

}
