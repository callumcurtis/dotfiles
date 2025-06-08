# NOTE: the stylix module must be added to your host's list of NixOS modules.

{ config, lib, ... }:

{
  options.dotfiles.features.stylix = {
    enable = lib.mkEnableOption "stylix";
  };

  config = lib.mkIf config.dotfiles.features.stylix.enable {
    stylix = {
      targets = {
        # Avoids: extension “user-theme@gnome-shell-extensions.gcampax.github.com” does not exist
        gnome.enable = false;
      };
    };
  };
}
