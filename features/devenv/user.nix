{ config, lib, pkgs, ... }:

{
  options.dotfiles.features.devenv.enable = lib.mkEnableOption "devenv";

  config = lib.mkIf config.dotfiles.features.devenv.enable {
    home.packages = with pkgs; [
      devenv
    ];
  };
}
