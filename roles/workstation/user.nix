{ config, lib, pkgs, dotfiles, ... }:

let
  shell = "${pkgs.fish}/bin/fish";
  terminal = "${pkgs.kitty}/bin/kitty";
  browser = "${pkgs.google-chrome}/bin/google-chrome-stable";

  hm = options: {
    imports = [
      ../../features/user.nix
    ];

    # Meta.
    dotfiles.features.home-manager.enable = true;

    # Desktop environment.
     #dotfiles.features.gnome.enable = true; # keep GNOME around for X11 applications
     #dotfiles.features.hyprland = {
     #  enable = true;
     #  monitors = options.monitors;
     #  exec-once = options.exec-once ++ [
     #    ((lib.strings.optionalString
     #      (options.initialWorkspace != "")
     #      "hyprctl dispatch workspace ${options.initialWorkspace} && ")
     #    + "hyprctl dispatch exec ${terminal} && "
     #    + "hyprctl dispatch exec ${browser}")
     #  ];
     #  inherit browser terminal;
     #};

    # GUI programs.
    dotfiles.features.google-chrome.enable = true;

    # Terminal configuration.
    dotfiles.features.kitty = {
      enable = true;
      inherit shell;
    };
    dotfiles.features.fish.enable = true;
    dotfiles.features.zellij = {
      enable = true;
      inherit shell;
    };
    dotfiles.features.neovim = {
      enable = true;
      asDefaultEditor = true;
    };
    dotfiles.features.cursor.enable = true;
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
    dotfiles.features.stylix.enable = true;
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
in
{
  options.dotfiles.users = lib.mkOption {
    default = {};
    type = lib.types.attrsOf (lib.types.submodule {
      options.roles.workstation = {
        enable = lib.mkEnableOption "workstation-user-role";
        monitors = dotfiles.lib.mkTypedOptionWithDefault (lib.types.listOf lib.types.str) [];
        # TODO: support passing a callback, parameterized by $browser and $terminal, to build exec-once
        # (instead of passing in initialWorkspace separately and starting $browser and $terminal in this file)
        exec-once = dotfiles.lib.mkTypedOptionWithDefault (lib.types.listOf lib.types.str) [];
        initialWorkspace = dotfiles.lib.mkTypedOptionWithDefault lib.types.str "";
      };
    });
  };

  config = {
    dotfiles.features.home-manager.users = builtins.mapAttrs
      (user: options: lib.mkIf options.roles.workstation.enable (hm options.roles.workstation))
      (config.dotfiles.users);
  };
}

