{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.modules.nixos.korean;
in
{
  options.modules.nixos.korean = lib.mkOption {
    default = true;
    type = lib.types.bool;
  };
  config = lib.mkIf cfg {
    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
        LC_ADDRESS = "ko_KR.UTF-8";
        LC_IDENTIFICATION = "ko_KR.UTF-8";
        LC_MEASUREMENT = "ko_KR.UTF-8";
        LC_MONETARY = "ko_KR.UTF-8";
        LC_NAME = "ko_KR.UTF-8";
        LC_NUMERIC = "ko_KR.UTF-8";
        LC_PAPER = "ko_KR.UTF-8";
        LC_TELEPHONE = "ko_KR.UTF-8";
        LC_TIME = "ko_KR.UTF-8";
      };

      inputMethod = {
        enable = true;
        type = "fcitx5";

        fcitx5 = {
          addons = with pkgs; [
            fcitx5-gtk
            fcitx5-hangul
          ];

          settings = {
            # config file
            globalOptions = {
              Hotkey = {
                EnumerateWithTriggerKeys = true;
                EnumerateSkipFirst = false;
                ModifierOnlyKeyTimeout = 250;
              };
              "Hotkey/TriggerKeys" = {
                "0" = "Control+Space";
                "1" = "Hangul";
              };
              "Hotkey/AltTriggerKeys"."0" = "Shift_L";
              "Hotkey/EnumerateGroupForwardKeys"."0" = "Super+space";
              "Hotkey/EnumerateGroupBackwardKeys"."0" = "Shift+Super+space";
              "Hotkey/ActivateKeys"."0" = "Hangul_Hanja";
              "Hotkey/DeactivateKeys"."0" = "Hangul_Romaja";
              "Hotkey/PrevPage"."0" = "Up";
              "Hotkey/NextPage"."0" = "Down";
              "Hotkey/PrevCandidate"."0" = "Shift+Tab";
              "Hotkey/NextCandidate"."0" = "Tab";
              "Hotkey/TogglePreedit"."0" = "Control+Alt+P";

              Behavior = {
                "ActiveByDefault" = false;
                "resetStateWhenFocusIn" = "No";
                "ShareInputState" = "No";
                "PreeditEnabledByDefault" = true;
                "ShowInputMethodInformation" = true;
                "showInputMethodInformationWhenFocusIn" = false;
                "CompactInputMethodInformation" = true;
                "ShowFirstInputMethodInformation" = true;
                "DefaultPageSize" = 5;
                "OverrideXkbOption" = false;
                "PreloadInputMethod" = true;
                "AllowInputMethodForPassword" = false;
                "ShowPreeditForPassword" = false;
                "AutoSavePeriod" = 30;
              };
            };

            # profile file
            inputMethod = {
              GroupOrder."0" = "Default";
              "Groups/0" = {
                name = "Default";
                "Default Layout" = "us";
                DefaultIM = "hangul";
              };
              "Groups/0/Items/0".Name = "keyboard-us";
              "Groups/0/Items/1".Name = "hangul";
            };

            addons = {
              hangul = {
                globalSection = {
                  Keyboard = "Dubeolsik";
                  AutoReorder = true;
                  WordCommit = false;
                  HanjaMode = false;
                };

                sections = {
                  HanjaModeToggleKey = {
                    "0" = "Hangul_Hanja";
                    "1" = "F9";
                  };

                  PrevPage."0" = "Up";
                  NextPage."0" = "Down";
                  PrevCandidate."0" = "Shift+Tab";
                  NextCandidate."0" = "Tab";
                };
              };
            };
          };
        };
      };
    };
    time.timeZone = lib.mkDefault "Asia/Seoul";
  };
}
