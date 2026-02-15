{ config, lib, pkgs, dotfiles, isDarwin ? false, ... }:

{
  options.dotfiles.features.hyprland.enable = lib.mkEnableOption "hyprland";

  config = lib.optionalAttrs (!isDarwin) (lib.mkIf config.dotfiles.features.hyprland.enable {
    programs.hyprland = {
      enable = true;
      package = dotfiles.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = dotfiles.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
  });
}

