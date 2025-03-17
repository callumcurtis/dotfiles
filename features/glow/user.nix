{ config, lib, pkgs, ... }:

{
  options.dotfiles.features.glow.enable = lib.mkEnableOption "glow";

  config = lib.mkIf config.dotfiles.features.glow.enable {
    home.packages = with pkgs; [
      glow
    ];
  };
}
