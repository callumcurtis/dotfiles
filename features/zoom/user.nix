{ config, lib, pkgs, ... }:

{
  options.dotfiles.features.zoom.enable = lib.mkEnableOption "zoom";

  config = lib.mkIf config.dotfiles.features.zoom.enable {
    home.packages = with pkgs; [
      unstable.zoom-us
    ];
  };
}
