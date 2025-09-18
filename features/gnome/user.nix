{ config, lib, pkgs, ... }:

{
  options.dotfiles.features.gnome.enable = lib.mkEnableOption "gnome";

  config = lib.mkIf config.dotfiles.features.gnome.enable {
    home.packages = with pkgs; [
      # xclip
    ];
  };
}
