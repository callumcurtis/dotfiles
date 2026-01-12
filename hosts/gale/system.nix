{ self, ... }:

let
  # Assign usernames to variables to avoid typos between usages.
  callumcurtis = "callumcurtis";
in
{
  imports = [
    ../../features/darwin.nix
    ../../devices
    ../../roles
    ../../constants
  ];

  networking.hostName = "gale";
  dotfiles.devices.ultralightx.enable = true;

  # Assign roles to users and the system.
  dotfiles.system.roles.workstation.enable = true;
  dotfiles.users.${callumcurtis}.roles.workstation.enable = true;

  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 6;
}

