# https://superuser.com/questions/1675877/how-to-create-a-new-pipewire-virtual-device-that-to-combines-an-real-input-and-o
# https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4370

{ pkgs, ... }:
let

  virtualSource = name: {
    factory = "adapter";
    args = {
      "factory.name" = "support.null-audio-sink";
      "node.name" = "${name}"; # a unique name for the stream
      "node.description" =
        "${name} (Virtual Source)"; # a human readable name for the stream
      "media.class" = "Audio/Source/Virtual";
      "audio.position" = "FL,FR";
      "object.linger" = true;

      "monitor.channel-volumes" = true;
      "monitor.passthrough" = true;
      "adapter.auto-port-config" = {
        "mode" = "dsp";
        "monitor" = true;
        "position" = "preserve";
      };
    };
  };

  virtualSink = name: {
    factory = "adapter";
    args = {
      "factory.name" = "support.null-audio-sink";
      "node.name" = "${name}"; # a unique name for the stream
      "node.description" =
        "${name} (Virtual Sink)"; # a human readable name for the stream
      "media.class" = "Audio/Sink";
      "audio.position" = "FL,FR";
      "object.linger" = true;

      "monitor.channel-volumes" = true;
      "monitor.passthrough" = true;
      "adapter.auto-port-config" = {
        "mode" = "dsp";
        "monitor" = true;
        "position" = "preserve";
      };
    };
  };

  createLink = { sinkName, sourceName }:
    map ({ outputPort, inputPort }: {
      factory = "link-factory";
      args = {
        "factory.name" = "link-with-${sinkName}-${sourceName}";
        # pw-link linked-sink-1:monitor_FL linked-source-1:input_FL
        # ^       OUTPUT                   INPUT
        "link.output.node" = sinkName;
        "link.output.port" = outputPort;

        "link.input.node" = sourceName;
        "link.input.port" = inputPort;
        "object.linger" = true;
      };
      flags = [ "nofail" ];
    }) [
      {
        outputPort = "monitor_FL";
        inputPort = "input_FL";
      }
      {
        outputPort = "monitor_FR";
        inputPort = "input_FR";
      }
    ];

  virtualLinked = name:
    let
      sinkName = "linked-sink-${name}";
      sourceName = "linked-source-${name}";
    in [
      (virtualSink sinkName)
      (virtualSource sourceName)
    ] ++ (createLink {sinkName = sinkName; sourceName = sourceName;});

in {
  config = {
    security.rtkit.enable = true;
    hardware.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      #jack.enable = true;

      /* extraConfig = {
           pipewire."92-low-latency" = {
             context.properties = {
               default.clock.rate = 48000;
               default.clock.quantum = 32;
               default.clock.min-quantum = 32;
               default.clock.max-quantum = 32;
             };
           };
         };
      */

      extraConfig = {
        pipewire = {
          /* # https://wiki.nixos.org/wiki/PipeWire#Low-latency_setup
             "92-low-latency" = {
               context.properties = {
                 default.clock.rate = 48000;
                 default.clock.quantum = 32;
                 default.clock.min-quantum = 32;
                 default.clock.max-quantum = 32;
               };
             }
          */

          # https://wiki.niredactedname" = "support.node.driver";
                  "node.name" = "Dummy-Driver";
                  "priority.driver" = 8000;
                };
              }
            ] ++ (virtualLinked "1") ++ (virtualLinked "2");
          };
        };
      };

    };

    # graphical tools
    environment.systemPackages = with pkgs; [ pavucontrol helvum ];
  };
}
