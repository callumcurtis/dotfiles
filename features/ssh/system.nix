{ config, lib, ...}:

{
  options.dotfiles.features.ssh.enable = lib.mkEnableOption "ssh";

  config = lib.mkIf config.dotfiles.features.ssh.enable { 
    services.openssh.enable = true;
  };
}
