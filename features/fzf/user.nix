{ config, lib, ... }:

{
  options.dotfiles.features.fzf.enable = lib.mkEnableOption "fzf";

  config = lib.mkIf config.dotfiles.features.fzf.enable {
    programs.fzf = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
