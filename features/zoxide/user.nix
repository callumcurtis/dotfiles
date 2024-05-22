{ config, lib, ... }:

{
  options.dotfiles.features.zoxide.enable = lib.mkEnableOption "zoxide";

  config = lib.mkIf config.dotfiles.features.zoxide.enable { 
    programs.zoxide.enable = true;
  };
}
