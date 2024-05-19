{ config, lib, pkgs, ... }:

let
hm = {

    imports = [
      ../../features/user.nix
      ../../lib
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

    home.packages = with pkgs; [
      lunarvim
      google-chrome
      (pkgs.nerdfonts.override { fonts = ["FiraMono"]; })
    ];

    dotfiles.features.fish.enable = true;

    programs.zoxide.enable = true;

    programs.starship.enable = true;

    programs.zellij = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        default_shell = "${pkgs.fish}/bin/fish";
        theme = "tokyo-night-dark";
        default_layout = "compact";
        pane_frames = false;
      };
    };

    programs.eza = {
      enable = true;
      icons = true;
      git = true;
    };

    dotfiles.features.git = {
      enable = true;
      user.name = config.dotfiles.constants.name.full;
      user.email = config.dotfiles.constants.email.github.noreply;
    };

    programs.kitty = {
      enable = true;
      font = {
        name = "FiraMono Nerd Font";
        size = 10;
      };
      theme = "Tokyo Night Moon";
      settings = {
        shell = "${pkgs.fish}/bin/fish";
      };
    };

    home.sessionVariables = {
      EDITOR = "${pkgs.lunarvim}/bin/lvim";
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

