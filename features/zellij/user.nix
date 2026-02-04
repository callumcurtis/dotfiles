{ config, lib, dotfiles, pkgs, ... }:

{
  options.dotfiles.features.zellij = {
    enable = lib.mkEnableOption "zellij";
    shell = dotfiles.lib.mkTypedOption lib.types.path;
    autoStartIn.fish = dotfiles.lib.mkTypedOptionWithDefault lib.types.bool true;
  };

  config = lib.mkIf config.dotfiles.features.zellij.enable {
    programs.zellij = {
      enable = true;
      enableFishIntegration = config.dotfiles.features.zellij.autoStartIn.fish;
    };

    xdg.configFile."zellij/config.kdl".source = pkgs.substitute {
      src = ./config.kdl;
      substitutions = [
        "--subst-var-by" "default_shell" "${config.dotfiles.features.zellij.shell}"
      ];
    };

    home.shellAliases = {
      rnt = "zellij action rename-tab";
      rnp = "zellij action rename-pane";
    };
  };
}
