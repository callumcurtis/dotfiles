{ config, lib, dotfiles, ... }:

let
  hm = options: {
    imports = [
      ./user.nix
    ];

    dotfiles.roles.workstation = {
      enable = true;
      inherit (options) monitors exec-once initialWorkspace;
    };
  };
in
{
  options.dotfiles.system.roles.workstation.enable = lib.mkEnableOption "workstation-system-role";

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

  config = lib.mkIf (config.dotfiles.system.roles.workstation.enable) {
    dotfiles.features.gnome.enable = true;
    dotfiles.features.hyprland.enable = true;
    dotfiles.features.grub.enable = true;
    dotfiles.features.networking.enable = true;
    dotfiles.features.printing.enable = true;
    dotfiles.features.flakes.enable = true;
    dotfiles.features.ssh.enable = true;
    dotfiles.features.fish.enable = true;
    dotfiles.features.blurred.enable = true;
    dotfiles.features.stylix = {
      enable = true;
      wallpaper = config.dotfiles.constants.wallpaper;
      theme = config.dotfiles.constants.theme;
    };
    dotfiles.features.docker = {
      enable = true;
      users = builtins.mapAttrs
        (user: options: { enable = options.roles.workstation.enable; })
        (config.dotfiles.users);
    };
    dotfiles.features.home-manager.enable = true;
    dotfiles.features.home-manager.users = builtins.mapAttrs
      (user: options: lib.mkIf options.roles.workstation.enable (hm options.roles.workstation))
      (config.dotfiles.users);

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;
  };
}
