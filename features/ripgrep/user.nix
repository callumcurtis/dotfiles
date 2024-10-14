{ config, lib, ... }:

{
  options.dotfiles.features.ripgrep.enable = lib.mkEnableOption "ripgrep";

  config = lib.mkIf config.dotfiles.features.ripgrep.enable {
    programs.ripgrep.enable = true;
  };
}
