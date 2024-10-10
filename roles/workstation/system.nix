{ config, lib, ... }:

{
  options.dotfiles.system.roles.workstation.enable = lib.mkEnableOption "workstation-system-role";

  config = lib.mkIf (config.dotfiles.system.roles.workstation.enable) {
    dotfiles.features.gnome.enable = true;
    dotfiles.features.grub.enable = true;
    dotfiles.features.networking.enable = true;
    dotfiles.features.printing.enable = true;
    dotfiles.features.audio.enable = true;
    dotfiles.features.flakes.enable = true;
    dotfiles.features.ssh.enable = true;
    dotfiles.features.fish.enable = true;
    dotfiles.features.nixvim.enable = false;
    dotfiles.features.docker = {
      enable = true;
      users = builtins.mapAttrs
        (user: options: { enable = options.roles.workstation.enable; })
        (config.dotfiles.users);
    };
    dotfiles.features.home-manager.enable = true;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;
  };
}

