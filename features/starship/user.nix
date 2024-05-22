{ config, lib, ... }:

{
  options.dotfiles.features.starship.enable = lib.mkEnableOption "starship";

  config = lib.mkIf config.dotfiles.features.starship.enable {
    programs.starship.enable = true;
  };
}
