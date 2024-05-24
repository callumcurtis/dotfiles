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

  networking.hostName = "mist";
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
}

