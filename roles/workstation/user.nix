{ config, lib, ... }:

let
hm = {

    imports = [
      ../../features/user.nix
      ../../constants
    ];

    fonts.fontconfig.enable = true;

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        document-font-name = "Liberation Sans 10";
        font-name = "Liberation Sans 10";
        monospace-font-name = "Liberation Mono 9";
     };
    };

    dotfiles.features.kitty = {
      enable = true;
      shell = config.dotfiles.constants.shell;
    };
    dotfiles.features.fish.enable = true;
    dotfiles.features.zellij = {
      enable = true;
      shell = config.dotfiles.constants.shell;
    };
    dotfiles.features.lunarvim = {
      enable = true;
      asDefaultEditor = true;
    };
    dotfiles.features.zoxide.enable = true;
    dotfiles.features.eza.enable = true;
    dotfiles.features.starship.enable = true;
    dotfiles.features.google-chrome.enable = true;

    dotfiles.features.git = {
      enable = true;
      user.name = config.dotfiles.constants.name.full;
      user.email = config.dotfiles.constants.email.github.noreply;
    };

    # This value determines the home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update home Manager without changing this value. See
    # the home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "23.11";

    # Let home Manager install and manage itself.
    programs.home-manager.enable = true;
  };

  enabledUsers = (
    builtins.listToAttrs (
      builtins.filter
        (pair: pair.value.roles.workstation.enable)
        (builtins.map
          (user: { name = user; value = config.dotfiles.users.${user}; })
          (builtins.attrNames config.dotfiles.users)
        )
    )
  );
in
{
  options.dotfiles.users = lib.mkOption {
    default = {};
    type = lib.types.attrsOf (lib.types.submodule {
      options.roles.workstation.enable = lib.mkEnableOption "workstation role";
    });
  };

  config = lib.mkIf (enabledUsers != {}) {
    home-manager.users = lib.mkIf (enabledUsers != {}) (builtins.mapAttrs (user: options: hm) enabledUsers);
  };
}

