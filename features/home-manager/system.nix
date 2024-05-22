{ config, lib, dotfiles, ... }:

{
  options.dotfiles.features.home-manager = {
    enable = lib.mkEnableOption "home-manager";
    users = dotfiles.lib.mkTypedOption lib.types.attrs;
  };

  config = lib.mkIf config.dotfiles.features.home-manager.enable { 
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users = config.dotfiles.features.home-manager.users;
  };
}
