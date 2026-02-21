{ config, lib, isDarwin, homebrew-core, homebrew-cask, ... }:

{
  options.dotfiles.features.homebrew = {
    enable = lib.mkEnableOption "homebrew";
    casks = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of homebrew casks to install";
    };
    brews = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of homebrew formulas to install";
    };
  };

  config = lib.optionalAttrs isDarwin (lib.mkIf config.dotfiles.features.homebrew.enable {
    nix-homebrew = {
      enable = true;
      user = config.dotfiles.constants.username;
      autoMigrate = true;
      mutableTaps = false;
      taps = {
        "homebrew/homebrew-core" = homebrew-core;
        "homebrew/homebrew-cask" = homebrew-cask;
      };
    };

    homebrew = {
      enable = true;
      user = config.dotfiles.constants.username;
      taps = builtins.attrNames config.nix-homebrew.taps;
      casks = config.dotfiles.features.homebrew.casks;
      brews = config.dotfiles.features.homebrew.brews;
    };
  });
}
