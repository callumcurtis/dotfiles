{ config, lib, ... }:

{
  options.dotfiles.features.bat.enable = lib.mkEnableOption "bat";

  config = lib.mkIf config.dotfiles.features.bat.enable {
    programs.bat.enable = true;
    home.shellAliases = {
      cat = "bat";
    };
  };
}
