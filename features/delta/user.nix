{ config, lib, ... }:

{
  options.dotfiles.features.delta.enable = lib.mkEnableOption "delta";

  config = lib.mkIf config.dotfiles.features.delta.enable {
    programs.delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        side-by-side = true;
        dark = true;
      };
    };
  };
}
