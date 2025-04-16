{ pkgs-unstable, ... }: {

  home.packages = with pkgs-unstable.gst_all_1; [
    gstreamer
    gstreamermm
    gst-vaapi
    #gst-plugins-ugly
    gst-plugins-good
    gst-plugins-bad
    gst-libav
    gst-plugins-rs
    gst-devtools
    gst-plugins-base
  ];

}
