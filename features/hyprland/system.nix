{ config, lib, hyprland, pkgs, ... }:

{
  options.dotfiles.features.hyprland.enable = lib.mkEnableOption "hyprland";

  config = lib.mkIf config.dotfiles.features.hyprland.enable {
    programs.hyprland = {
      enable = true;
      package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
  };
}

