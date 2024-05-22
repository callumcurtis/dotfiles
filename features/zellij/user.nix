{ config, lib, dotfiles, ... }:

{
  options.dotfiles.features.zellij = {
    enable = lib.mkEnableOption "zellij";
    shell = lib.mkOption {
      type = lib.types.str;
    };
    autoStartIn.fish = dotfiles.lib.mkBoolOptionWithDefaultTrue "zellij auto-start in fish";
  };

  config = {
    programs.zellij = {
      enable = config.dotfiles.features.zellij.enable;
      enableFishIntegration = config.dotfiles.features.zellij.autoStartIn.fish;
      settings = {
        default_shell = config.dotfiles.features.zellij.shell;
        # TODO(#1): use stylix to manage themes.
        theme = "tokyo-night-dark";
        default_layout = "compact";
        pane_frames = false;
      };
    };
  };
}
