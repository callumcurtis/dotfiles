{ config, lib, dotfiles, ... }:

{
  options.dotfiles.features.kitty = {
    enable = lib.mkEnableOption "kitty";
    shell = dotfiles.lib.mkTypedOption lib.types.path;
  };

  config = lib.mkIf config.dotfiles.features.kitty.enable {
    programs.kitty = {
      enable = true;
      settings = {
        shell = config.dotfiles.features.kitty.shell;
        cursor_trail = 50;
        cursor_trail_decay = "0.05 0.10";
        confirm_os_window_close = 0;
      };
    };
  };
}
