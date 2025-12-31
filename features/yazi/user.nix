{ config, lib, ... }:

{
  options.dotfiles.features.yazi.enable = lib.mkEnableOption "yazi";

  config = lib.mkIf config.dotfiles.features.yazi.enable {
    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
      shellWrapperName = "y";
      keymap = {
        mgr.prepend_keymap = [
          # Invert default keymap for changing working directory when exiting yazi
          { run = "quit --no-cwd-file"; on = [ "q" ]; }
          { run = "quit"; on = [ "Q" ]; }
        ];
      };
    };
  };
}
