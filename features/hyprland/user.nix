{ config, lib, pkgs, hyprland, dotfiles, ... }:

{
  options.dotfiles.features.hyprland = {
    enable = lib.mkEnableOption "hyprland";
    browser = dotfiles.lib.mkTypedOption lib.types.path;
    terminal = dotfiles.lib.mkTypedOption lib.types.path;
    monitors = dotfiles.lib.mkTypedOptionWithDefault (lib.types.listOf lib.types.str) [];
  };

  config = lib.mkIf config.dotfiles.features.hyprland.enable {
    home.packages = with pkgs; [
      brightnessctl
      cliphist
      wl-clipboard
      hyprpicker
      hyprpolkitagent
      dunst
      hyprshot
    ];
    programs.rofi = {
      enable = true;
      extraConfig = {
        kb-row-down = "Control+j";
        kb-row-up = "Control+k";
        kb-accept-entry = "Control+l,Return,KP_Enter";

        # remove conflicts for the above mappings
        kb-remove-to-eol = "";
        kb-mode-complete = "";
      };
    };
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          lock_cmd = "hyprlock";
        };
        listener = [
          {
            timeout = 900;
            on-timeout = "hyprlock";
          }
          {
            timeout = 1200;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
    programs.hyprlock = {
      enable = true;
      settings.auth."pam:enabled" = true;
    };

    wayland.windowManager.hyprland = {
      enable = true;
      package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      systemd.variables = ["--all"];
      settings = {
        "$mod" = "SUPER";

        animations = {
          enabled = true;
          bezier = [
            "easeOutQuint,   0.23, 1,    0.32, 1"
            "easeInOutCubic, 0.65, 0.05, 0.36, 1"
            "linear,         0,    0,    1,    1"
            "almostLinear,   0.5,  0.5,  0.75, 1"
            "quick,          0.15, 0,    0.1,  1"
          ];
          animation = [
            "global,        1,     10,    default"
            "border,        1,     5.39,  easeOutQuint"
            "windows,       1,     4.79,  easeOutQuint"
            "windowsIn,     1,     0.5,   easeOutQuint, popin 87%"
            "windowsOut,    1,     1.0,   linear,       popin 87%"
            "fadeIn,        1,     1.73,  almostLinear"
            "fadeOut,       1,     1.46,  almostLinear"
            "fade,          1,     3.03,  quick"
            "layers,        1,     3.81,  easeOutQuint"
            "layersIn,      1,     4,     easeOutQuint, fade"
            "layersOut,     1,     1.5,   linear,       fade"
            "fadeLayersIn,  1,     1.79,  almostLinear"
            "fadeLayersOut, 1,     1.39,  almostLinear"
            "workspaces,    1,     1.94,  almostLinear, fade"
            "workspacesIn,  1,     1.21,  almostLinear, fade"
            "workspacesOut, 1,     1.94,  almostLinear, fade"
            "zoomFactor,    1,     7,     quick"
          ];
        };

        monitor = config.dotfiles.features.hyprland.monitors;

        input = {
          kb_options = "caps:escape";
        };

        cursor = {
          no_hardware_cursors = 1; # fixes flickering cursor and displayed offset
        };

        decoration = {
          dim_inactive = true;
          dim_strength = 0.2;
        };

        general = {
          border_size = 1;
          gaps_in = 5;
          gaps_out = 5;
        };

        ecosystem = {
          no_donation_nag = true;
        };

        exec-once = [
          "wl-paste --type text --watch cliphist store" # text
          "wl-paste --type image --watch cliphist store" # image
          "systemctl --user start hyprpolkitagent" # GUI for authentication
          "waybar &"
        ];

        bind =
          [
            # applications
            "$mod, b, exec, ${config.dotfiles.features.hyprland.browser}"
            "$mod, t, exec, ${config.dotfiles.features.hyprland.terminal}"
            "$mod, v, exec, cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy"
            "$mod, space, exec, rofi -show drun"
            "$mod, c, exec, hyprpicker"
            "$mod, s, exec, hyprshot -m region"
            "$mod shift, s, exec, hyprshot -m window"

            # modify window
            "$mod, q, killactive,"
            "$mod, f, fullscreen,"

            # move window
            "$mod shift, h, movewindow, l"
            "$mod shift, l, movewindow, r"
            "$mod shift, k, movewindow, u"
            "$mod shift, j, movewindow, d"

            # move window (between workspaces)
            "$mod shift, 1, movetoworkspace, 1"
            "$mod shift, 2, movetoworkspace, 2"
            "$mod shift, 3, movetoworkspace, 3"
            "$mod shift, 4, movetoworkspace, 4"
            "$mod shift, 5, movetoworkspace, 5"
            "$mod shift, 6, movetoworkspace, 6"
            "$mod shift, 7, movetoworkspace, 7"
            "$mod shift, 8, movetoworkspace, 8"
            "$mod shift, 9, movetoworkspace, 9"
            "$mod shift, 0, movetoworkspace, 10"

            # swap window
            "$mod alt, h, swapwindow, l"
            "$mod alt, l, swapwindow, r"
            "$mod alt, k, swapwindow, u"
            "$mod alt, j, swapwindow, d"

            # change focus
            "$mod, h, movefocus, l"
            "$mod, l, movefocus, r"
            "$mod, k, movefocus, u"
            "$mod, j, movefocus, d"
            "alt, tab, cyclenext"
            "alt, tab, bringactivetotop"

            # change workspace (absolute)
            "$mod, 1, workspace, 1"
            "$mod, 2, workspace, 2"
            "$mod, 3, workspace, 3"
            "$mod, 4, workspace, 4"
            "$mod, 5, workspace, 5"
            "$mod, 6, workspace, 6"
            "$mod, 7, workspace, 7"
            "$mod, 8, workspace, 8"
            "$mod, 9, workspace, 9"
            "$mod, 0, workspace, 10"

            # change workspace (relative)
            "$mod control, l, workspace, e+1"
            "$mod control, h, workspace, e-1"

            # audio
            ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
            ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ",XF86AudioPlay, exec, playerctl play-pause"
            ",XF86AudioPause, exec, playerctl play-pause"
            ",XF86AudioNext, exec, playerctl next"
            ",XF86AudioPrev, exec, playerctl previous"

            # brightness
            ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
            ",XF86MonBrightnessUp, exec, brightnessctl set +5%"
          ]
          ++ (
            # workspaces
            # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
            builtins.concatLists (builtins.genList (i:
                let ws = i + 1;
                in [
                  "$mod, code:1${toString i}, workspace, ${toString ws}"
                  "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                ]
              )
              9)
          );

          bindm = [
            # move window (left-click)
            "$modifier, mouse:272, movewindow"

            # resize window (right-click)
            "$modifier, mouse:273, resizewindow"
          ];
      };
    };
    home.sessionVariables.NIXOS_OZONE_WL = "1";

    programs.waybar = {
      enable = true;
      package = pkgs.waybar;
      settings = [
        {
          layer = "top";
          position = "top";
          modules-left = [
            "pulseaudio"
            "cpu"
            "memory"
            "disk"
            "network"
          ];
          modules-center = [ "hyprland/workspaces" ];
          modules-right = [
            "battery"
            "clock"
          ];

          "hyprland/workspaces" = {
            format = "{icon}";
            format-icons = {
                active = "";
                default = "";
                empty = "";
            };
            persistent-workspaces = {
                "*" = [ 1 2 3 4 5 ];
            };
          };
          "clock" = {
            format = "{:L%I:%M %p %m/%d/%Y}";
            tooltip = false;
          };
          "memory" = {
            interval = 5;
            format = " {}%";
            tooltip = true;
          };
          "cpu" = {
            interval = 5;
            format = " {usage}%";
            tooltip = true;
          };
          "disk" = {
            format = " {percentage_used}%";
            tooltip = true;
          };
          "network" = {
            format-icons = [
              "󰤯"
              "󰤟"
              "󰤢"
              "󰤥"
              "󰤨"
            ];
            format-ethernet = " {bandwidthDownOctets}";
            format-wifi = "{icon} {signalStrength}%";
            format-disconnected = "󰤮";
            tooltip = false;
          };
          "pulseaudio" = {
            format = "{icon} {volume}%";
            format-bluetooth = "{icon}󰂯 {volume}%";
            format-bluetooth-muted = "󰂯";
            format-muted = "";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = [
                ""
                ""
                ""
              ];
            };
            on-click = "pavucontrol";
          };
          "battery" = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon} {capacity}%";
            format-charging = "󰂄 {capacity}%";
            format-plugged = "󱘖 {capacity}%";
            format-icons = [
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
            on-click = "";
            tooltip = false;
          };
        }
      ];
      style = lib.concatStrings [
        ''
          * {
            font-size: 14px;
            font-family: "FiraMono Nerd Font Mono";
          }
          window#waybar {
            all:unset;
          }
          .modules-left {
              padding:7px;
              margin:10 0 5 10;
              border-radius:10px;
              background: alpha(#${config.lib.stylix.colors.base00},.6);
              box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
          }
          .modules-center {
              padding:7px;
              margin:10 0 5 0;
              border-radius:10px;
              background: alpha(#${config.lib.stylix.colors.base00},.6);
              box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
          }
          .modules-right {
              padding:7px;
              margin: 10 10 5 0;
              border-radius:10px;
              background: alpha(#${config.lib.stylix.colors.base00},.6);
              box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
          }
          #workspaces button {
              all:unset;
              padding: 0px 5px;
              color: alpha(#${config.lib.stylix.colors.base05},.4);
              transition: all .2s ease;
          }
          #workspaces button:hover {
              color:rgba(0,0,0,0);
              border: none;
              text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .5);
              transition: all 0.4s ease;
          }
          #workspaces button.active {
              color: alpha(#${config.lib.stylix.colors.base05},.8);
              border: none;
              text-shadow: 0px 0px 2px rgba(0, 0, 0, .5);
          }
          #workspaces button.empty {
              color: rgba(0,0,0,0);
              border: none;
              text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .2);
          }
          #workspaces button.empty:hover {
              color: rgba(0,0,0,0);
              border: none;
              text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .5);
              transition: all 1s ease;
          }
          #workspaces button.empty.active {
              color: alpha(#${config.lib.stylix.colors.base05},.8);
              border: none;
              text-shadow: 0px 0px 2px rgba(0, 0, 0, .5);
          }
          tooltip {
            background: #${config.lib.stylix.colors.base00};
            border: 1px solid #${config.lib.stylix.colors.base05};
            border-radius: 12px;
            color: #${config.lib.stylix.colors.base05};
          }
          #pulseaudio, #cpu, #memory, #disk, #network, #battery, #clock {
            color: alpha(#${config.lib.stylix.colors.base05},.8);
            padding: 0px 8px;
            transition: all .3s ease;
          }
        ''
      ];
    };

  };
}
