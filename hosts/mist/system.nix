{ config, ... }:

{
  imports = [
    ../../features/system.nix
    ../../roles
    ../../constants
  ];

  networking.hostName = "mist";
  dotfiles.features.multi-boot.windows.enable = true;
  dotfiles.features.ultralightx.enable = true;

  # Don't forget to set a password with ‘passwd’.
  users.users.${config.dotfiles.constants.username} = {
    isNormalUser = true;
    description = config.dotfiles.constants.name.full;
    extraGroups = [ "networkmanager" "wheel" "video" ];
  };

  # Assign roles to users and the system.
  dotfiles.system.roles.workstation.enable = true;
  dotfiles.users.${config.dotfiles.constants.username}.roles.workstation.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11";
}

