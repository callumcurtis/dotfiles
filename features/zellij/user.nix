{ config, lib, dotfiles, ... }:

{
  options.dotfiles.features.zellij = {
    enable = lib.mkEnableOption "zellij";
    shell = dotfiles.lib.mkTypedOption lib.types.path;
    autoStartIn.fish = dotfiles.lib.mkTypedOptionWithDefault lib.types.bool true;
  };

  config = lib.mkIf config.dotfiles.features.zellij.enable {
    programs.zellij = {
      enable = true;
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
