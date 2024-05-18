{ nixpkgs, home-manager, ... }:

nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    home-manager.nixosModules.home-manager
    ./system.nix
    ./hardware.nix
    ../../roles
    ../../devices
    {
      _module.args.dotfiles = {
        lib = (import ../../lib) nixpkgs;
        constants = (import ../../constants) nixpkgs;
      };
    }
  ];
}

