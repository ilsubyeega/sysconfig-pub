{ pkgs, ... }:
{
  home.packages = [
    (pkgs.buildFHSEnv {
      name = "gstreamer-fhs-linked";
      targetPkgs =
        pkgs:
        (with pkgs; [
          gst_all_1.gstreamer
          gst_all_1.gstreamermm
          gst_all_1.gst-vaapi
          gst_all_1.gst-plugins-base
          gst_all_1.gst-plugins-good
          gst_all_1.gst-plugins-bad
          gst_all_1.gst-plugins-rs
          gst_all_1.gst-libav
          gst_all_1.gst-devtools
          pipewire
        ]);
    })
  ];
}
