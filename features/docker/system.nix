{ config, lib, isDarwin ? false, ... }:

{
  options.dotfiles.features.docker = {
    enable = lib.mkEnableOption "docker";
    users = lib.mkOption {
      default = {};
      type = lib.types.attrsOf (lib.types.submodule {
        options.enable = lib.mkEnableOption "docker-group-membership";
      });
    };
  };

  config = lib.optionalAttrs (!isDarwin) (lib.mkIf config.dotfiles.features.docker.enable {
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
    users.users = builtins.mapAttrs
      (user: options: { extraGroups = lib.mkIf options.enable [ "docker" ]; })
      (config.dotfiles.features.docker.users);
  });
}
