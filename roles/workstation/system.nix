{ config, lib, ... }:

{
  options.dotfiles.system.roles.workstation.enable = lib.mkEnableOption "workstation role";

  config = lib.mkIf (config.dotfiles.system.roles.workstation.enable) {
    dotfiles.features.gnome.enable = true;
    dotfiles.features.grub.enable = true;
    dotfiles.features.networking.enable = true;
    dotfiles.features.printing.enable = true;
    dotfiles.features.audio.enable = true;
    dotfiles.features.flakes.enable = true;
    dotfiles.features.ssh.enable = true;
    dotfiles.features.unpatched-binaries.enable = true;
    dotfiles.features.fish.enable = true;
    dotfiles.features.home-manager.enable = true;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;
  };
}

