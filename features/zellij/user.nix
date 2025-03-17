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

    xdg.configFile."zellij/themes/stylix.kdl".text = lib.mkIf (config.stylix.enable) (
      with config.lib.stylix.colors.withHashtag; ''
        themes {
          default {
            bg "${base01}";
            fg "${base05}";
            red "${base08}";
            green "${base04}";
            blue "${base0D}";
            yellow "${base0A}";
            magenta "${base0E}";
            orange "${base09}";
            cyan "${base0C}";
            black "${base01}";
            white "${base05}";
          }
        }
      '');

    xdg.configFile."zellij/config.kdl".source = pkgs.substitute {
      src = ./config.kdl;
      substitutions = [
        "--subst-var-by" "default_shell" "${config.dotfiles.features.zellij.shell}"
      ];
    };
  };
}
