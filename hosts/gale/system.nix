{ self, config, ... }:

{
  imports = [
    ../../features/system.nix
    ../../roles
    ../../constants
  ];

  networking.hostName = "gale";

  users.users.${config.dotfiles.constants.username} = {
    description = config.dotfiles.constants.name.full;
    home = "/Users/${config.dotfiles.constants.username}";
    name = config.dotfiles.constants.username;
  };

  # Assign roles to users and the system.
  dotfiles.system.roles.workstation.enable = true;
  dotfiles.users.${config.dotfiles.constants.username}.roles.workstation.enable = true;

  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 6;
}

