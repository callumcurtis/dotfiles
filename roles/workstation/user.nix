{ config, lib, pkgs, dotfiles, ... }:

let
  shell = "${pkgs.fish}/bin/fish";
  terminal = "${pkgs.kitty}/bin/kitty";
  browser = "${pkgs.google-chrome}/bin/google-chrome-stable";
in
{
  imports = [
    ../../features/user.nix
    ../../constants
  ];

  options.dotfiles.roles.workstation = {
    enable = lib.mkEnableOption "workstation-user-role";
    monitors = dotfiles.lib.mkTypedOptionWithDefault (lib.types.listOf lib.types.str) [];
    # TODO: support passing a callback, parameterized by $browser and $terminal, to build exec-once
    # (instead of passing in initialWorkspace separately and starting $browser and $terminal in this file)
    exec-once = dotfiles.lib.mkTypedOptionWithDefault (lib.types.listOf lib.types.str) [];
    initialWorkspace = dotfiles.lib.mkTypedOptionWithDefault lib.types.str "";
  };

  config = lib.mkIf config.dotfiles.roles.workstation.enable {
    # Meta.
    dotfiles.features.home-manager.enable = true;

    # Desktop environment.
    dotfiles.features.gnome.enable = true; # keep GNOME around for X11 applications
    dotfiles.features.hyprland = {
      enable = true;
      monitors = config.dotfiles.roles.workstation.monitors;
      exec-once = config.dotfiles.roles.workstation.exec-once ++ [
        ((lib.strings.optionalString
          (config.dotfiles.roles.workstation.initialWorkspace != "")
          "hyprctl dispatch workspace ${config.dotfiles.roles.workstation.initialWorkspace} && ")
        + "hyprctl dispatch exec ${terminal} && "
        + "hyprctl dispatch exec ${browser}")
      ];
      inherit browser terminal;
    };
    dotfiles.features.aerospace = {
      enable = true;
      inherit terminal browser;
    };

    # GUI programs.
    dotfiles.features.google-chrome.enable = true;
    dotfiles.features.zoom.enable = true;
    dotfiles.features.cursor.enable = true;
    dotfiles.features.kitty = {
      enable = true;
      inherit shell;
    };

    # Terminal configuration.
    dotfiles.features.coreutils.enable = true;
    dotfiles.features.fish.enable = true;
    dotfiles.features.zellij = {
      enable = true;
      inherit shell;
    };
    dotfiles.features.neovim = {
      enable = true;
      asDefaultEditor = true;
    };
    dotfiles.features.direnv.enable = true;
    dotfiles.features.zoxide.enable = true;
    dotfiles.features.eza.enable = true;
    dotfiles.features.yazi.enable = true;
    dotfiles.features.btop.enable = true;
    dotfiles.features.dust.enable = true;
    dotfiles.features.fastfetch.enable = true;
    dotfiles.features.fzf.enable = true;
    dotfiles.features.ripgrep.enable = true;
    dotfiles.features.starship.enable = true;
    dotfiles.features.stylix = {
      enable = true;
      theme = config.dotfiles.constants.theme;
    };
    dotfiles.features.glow.enable = true;
    dotfiles.features.bat.enable = true;
    dotfiles.features.tldr.enable = true;
    dotfiles.features.metarepo.enable = true;
    dotfiles.features.claude-code.enable = true;
    dotfiles.features.delta.enable = true;

    dotfiles.features.git = {
      enable = true;
      user.name = config.dotfiles.constants.name.full;
      user.email = config.dotfiles.constants.email.github.noreply;
    };
  };
}
