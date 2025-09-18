{ config, lib, pkgs, ... }:

{
  options.dotfiles.features.audio.enable = lib.mkEnableOption "audio";

  config = lib.mkIf config.dotfiles.features.audio.enable {
    home.packages = with pkgs; [
      pavucontrol
    ];
  };
}
