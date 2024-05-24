{ config, lib, ... }:

{
  options.dotfiles.features.unpatched-binaries.enable = lib.mkEnableOption "unpatched-binaries";

  config = lib.mkIf config.dotfiles.features.unpatched-binaries.enable {
     # Enable running unpatched binaries (simplifies using pip and other package managers).
    programs.nix-ld.enable = true;
  };
}
