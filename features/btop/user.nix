{ config, lib, ... }:

{
  options.dotfiles.features.btop.enable = lib.mkEnableOption "btop";

  config = lib.mkIf config.dotfiles.features.btop.enable {
    programs.btop = {
      enable = true;
    };
  };
}
