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
      };
    };
  };
}
