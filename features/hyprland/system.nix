{ config, lib, pkgs, dotfiles, isNixos, ... }:

{
  options.dotfiles.features.hyprland.enable = lib.mkEnableOption "hyprland";

  config = lib.optionalAttrs isNixos (lib.mkIf config.dotfiles.features.hyprland.enable {
    programs.hyprland = {
      enable = true;
      package = dotfiles.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = dotfiles.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
  });
}

