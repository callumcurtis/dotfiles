{ config, lib, ... }:

{
  options.dotfiles.features.flakes.enable = lib.mkEnableOption "flakes";

  config = lib.mkIf config.dotfiles.features.flakes.enable { 
    nix.settings.experimental-features = ["nix-command" "flakes"];
  };
}

