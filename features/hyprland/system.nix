{ config, lib, pkgs, dotfiles, ... }:

{
  options.dotfiles.features.hyprland.enable = lib.mkEnableOption "hyprland";

  config = lib.mkIf config.dotfiles.features.hyprland.enable {
    programs.hyprland = {
      enable = true;
      package = dotfiles.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = dotfiles.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
  };
}

