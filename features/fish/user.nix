{ config, lib, ... }:

{
  options.dotfiles.features.fish.enable = lib.mkEnableOption "fish";

  config = lib.mkIf config.dotfiles.features.fish.enable {
    programs.fish = {
      enable = true;
      functions = {
        fish_greeting = "";
      };
    };
  };
}

