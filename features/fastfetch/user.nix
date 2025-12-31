{ config, lib, ... }:

{
  options.dotfiles.features.fastfetch.enable = lib.mkEnableOption "fastfetch";

  config = lib.mkIf config.dotfiles.features.fastfetch.enable {
    programs.fastfetch = {
      enable = true;
    };
  };
}
