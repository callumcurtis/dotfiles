{ self, config, ... }:

let
  # Assign usernames to variables to avoid typos between usages.
  callumcurtis = "callumcurtis";
in
{
  imports = [
    ../../features/system.nix
    ../../roles
    ../../constants
  ];

  networking.hostName = "gale";

  users.users.${callumcurtis} = {
    description = config.dotfiles.constants.name.full;
    home = "/Users/${callumcurtis}";
    name = callumcurtis;
  };

  # Assign roles to users and the system.
  dotfiles.system.roles.workstation.enable = true;
  dotfiles.users.${callumcurtis}.roles.workstation.enable = true;

  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 6;
}

