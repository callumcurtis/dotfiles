{ config, lib, ... }:

{
  options.dotfiles.features.tldr.enable = lib.mkEnableOption "tldr";

  config = lib.mkIf config.dotfiles.features.tldr.enable {
    programs.tealdeer = {
      enable = true;
      settings.updates.auto_update = true;
    };
  };
}
