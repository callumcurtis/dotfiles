{ config, ... }:

let
  # Assign usernames to variables to avoid typos between usages.
  callumcurtis = "callumcurtis";
  monitors = [
    "DP-1, 2560x1440@165, 0x0, 1, transform, 1"
    "DP-2, 2560x1440@165, 1440x560, 1"
  ];
  initialWorkspace = "2";
in
{
  imports = [
    ../../features/system.nix
    ../../roles
    ../../constants
  ];

  networking.hostName = "wind";
  dotfiles.features.multi-boot.windows.enable = true;
  dotfiles.features.ultralightx.enable = true;

  # Don't forget to set a password with ‘passwd’.
  users.users.${callumcurtis} = {
    isNormalUser = true;
    description = config.dotfiles.constants.name.full;
    extraGroups = [ "networkmanager" "wheel" "video" ];
  };

  # Assign roles to users and the system.
  dotfiles.system.roles.workstation.enable = true;
  dotfiles.users.${callumcurtis}.roles.workstation = {
    enable = true;
    inherit monitors initialWorkspace;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05";
}

