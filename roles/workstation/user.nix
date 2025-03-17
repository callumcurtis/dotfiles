{ config, lib, ... }:

let
  hm = {
    imports = [
      ../../features/user.nix
    ];

    # Meta.
    dotfiles.features.home-manager.enable = true;

    # Desktop environment.
    # TODO: the desktop environment should be selected by the system configuration
    dotfiles.features.gnome.enable = true;

    # GUI programs.
    dotfiles.features.google-chrome.enable = true;

    # Terminal configuration.
    dotfiles.features.kitty = {
      enable = true;
      shell = config.dotfiles.constants.shell;
    };
    dotfiles.features.fish.enable = true;
    dotfiles.features.zellij = {
      enable = true;
      shell = config.dotfiles.constants.shell;
    };
    dotfiles.features.neovim = {
      enable = true;
      asDefaultEditor = true;
    };
    dotfiles.features.direnv.enable = true;
    dotfiles.features.zoxide.enable = true;
    dotfiles.features.eza.enable = true;
    dotfiles.features.ripgrep.enable = true;
    dotfiles.features.starship.enable = true;
    dotfiles.features.glow.enable = true;
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
      options.roles.workstation.enable = lib.mkEnableOption "workstation-user-role";
    });
  };

  config = {
    dotfiles.features.home-manager.users = builtins.mapAttrs
      (user: options: lib.mkIf options.roles.workstation.enable hm)
      (config.dotfiles.users);
  };
}

