{ config, ... }:

let
  # Assign usernames to variables to avoid typos between usages.
  callumcurtis = "callumcurtis";
in
{
  imports = [
    ../../features/system.nix
    ../../devices
    ../../roles
    ../../constants
  ];

  networking.hostName = "wind";
  dotfiles.features.multi-boot.windows.enable = true;
  dotfiles.devices.ultralightx.enable = true;

  # Don't forget to set a password with ‘passwd’.
  users.users.${callumcurtis} = {
    isNormalUser = true;
    description = config.dotfiles.constants.name.full;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Assign roles to users and the system.
  dotfiles.system.roles.workstation.enable = true;
  dotfiles.users.${callumcurtis}.roles.workstation.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05";
}

