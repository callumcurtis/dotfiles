{ config, lib, pkgs, ... }:

{
  options.dotfiles.features.google-chrome.enable = lib.mkEnableOption "google-chrome";

  config = lib.mkIf config.dotfiles.features.google-chrome.enable {
    home.packages = with pkgs; [
      unstable.google-chrome
    ];
  };
}
