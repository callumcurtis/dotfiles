{ config, lib, zen-browser, ... }:

{
  options.dotfiles.features.zen.enable = lib.mkEnableOption "zen";

  imports = [
    zen-browser.homeModules.beta
  ];

  config = lib.mkIf config.dotfiles.features.zen.enable {
    programs.zen-browser.enable = true;
  };
}
