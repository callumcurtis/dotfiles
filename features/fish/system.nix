{ config, lib, ... }:

{
  options.dotfiles.features.fish.enable = lib.mkEnableOption "fish";

  config = lib.mkIf config.dotfiles.features.fish.enable {
    # Enable vendor completions provided by nixpgs
    programs.fish.enable = true;
  };
}
