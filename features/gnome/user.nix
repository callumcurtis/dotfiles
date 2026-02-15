{ config, lib, pkgs, isNixos, ... }:

{
  options.dotfiles.features.gnome.enable = lib.mkEnableOption "gnome";

  config = lib.optionalAttrs isNixos (lib.mkIf config.dotfiles.features.gnome.enable {
    home.packages = with pkgs; [
      xclip
    ];
  });
}
