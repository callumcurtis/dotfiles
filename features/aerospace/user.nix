{ config, pkgs, lib, dotfiles, isDarwin, ... }:

{
  options.dotfiles.features.aerospace = {
    enable = lib.mkEnableOption "aerospace";
    browser = dotfiles.lib.mkTypedOption lib.types.path;
    terminal = dotfiles.lib.mkTypedOption lib.types.path;
  };

  config = lib.optionalAttrs isDarwin (lib.mkIf config.dotfiles.features.aerospace.enable {
    home.packages = with pkgs; [
      maccy
    ];
    programs.aerospace = {
      enable = true;
      launchd.enable = true;
      userSettings = {
        # Normalizations. See: https://nikitabobko.github.io/AeroSpace/guide#normalization
        enable-normalization-flatten-containers = true;
        enable-normalization-opposite-orientation-for-nested-containers = true;

        # Gaps
        gaps = {
          inner.horizontal = 5;
          inner.vertical = 5;
          outer.left = 5;
          outer.bottom = 5;
          outer.top = 5;
          outer.right = 5;
        };

        # Workspace to monitor assignments
        workspace-to-monitor-force-assignment = {
          "1" = 1;
          "2" = 2;
          "3" = 3;
        };

        # Define modes
        mode.main.binding = {
          # Applications (using alt as modifier, matching Hyprland's SUPER)
          alt-b = "exec-and-forget open -a \"${config.dotfiles.features.aerospace.browser}\"";
          alt-t = "exec-and-forget open -a \"${config.dotfiles.features.aerospace.terminal}\"";
          alt-v = "exec-and-forget open -a \"Maccy\""; # Clipboard manager for macOS
          alt-c = "exec-and-forget open -a \"Digital Color Meter\""; # Color picker built into macOS
          alt-s = "exec-and-forget screencapture -i ~/Desktop/screenshot.png"; # Screenshot region
          alt-shift-s = "exec-and-forget screencapture -w ~/Desktop/screenshot.png"; # Screenshot window

          # Modify window
          alt-q = "close";
          alt-f = "fullscreen";

          # Change focus
          alt-h = ["focus left" "move-mouse monitor-force-center" "move-mouse window-force-center"];
          alt-l = ["focus right" "move-mouse monitor-force-center" "move-mouse window-force-center"];
          alt-k = ["focus up" "move-mouse monitor-force-center" "move-mouse window-force-center"];
          alt-j = ["focus down" "move-mouse monitor-force-center" "move-mouse window-force-center"];
          alt-tab = ["workspace-back-and-forth" "move-mouse monitor-force-center" "move-mouse window-force-center"];

          # Move window
          alt-shift-h = "move left";
          alt-shift-l = "move right";
          alt-shift-k = "move up";
          alt-shift-j = "move down";

          # Change workspace (absolute)
          alt-1 = ["workspace 1" "move-mouse monitor-force-center" "move-mouse window-force-center"];
          alt-2 = ["workspace 2" "move-mouse monitor-force-center" "move-mouse window-force-center"];
          alt-3 = ["workspace 3" "move-mouse monitor-force-center" "move-mouse window-force-center"];
          alt-4 = ["workspace 4" "move-mouse monitor-force-center" "move-mouse window-force-center"];
          alt-5 = ["workspace 5" "move-mouse monitor-force-center" "move-mouse window-force-center"];
          alt-6 = ["workspace 6" "move-mouse monitor-force-center" "move-mouse window-force-center"];
          alt-7 = ["workspace 7" "move-mouse monitor-force-center" "move-mouse window-force-center"];
          alt-8 = ["workspace 8" "move-mouse monitor-force-center" "move-mouse window-force-center"];
          alt-9 = ["workspace 9" "move-mouse monitor-force-center" "move-mouse window-force-center"];
          alt-0 = ["workspace 10" "move-mouse monitor-force-center" "move-mouse window-force-center"];

          # Move window to workspace
          alt-shift-1 = "move-node-to-workspace 1";
          alt-shift-2 = "move-node-to-workspace 2";
          alt-shift-3 = "move-node-to-workspace 3";
          alt-shift-4 = "move-node-to-workspace 4";
          alt-shift-5 = "move-node-to-workspace 5";
          alt-shift-6 = "move-node-to-workspace 6";
          alt-shift-7 = "move-node-to-workspace 7";
          alt-shift-8 = "move-node-to-workspace 8";
          alt-shift-9 = "move-node-to-workspace 9";
          alt-shift-0 = "move-node-to-workspace 10";

          # Layout commands
          alt-slash = "layout tiles horizontal vertical";
          alt-comma = "layout accordion horizontal vertical";
        };
      };
    };
  });
}
