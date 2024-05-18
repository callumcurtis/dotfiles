{ nixpkgs, home-manager, ... }:

nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    home-manager.nixosModules.home-manager
    ./system.nix
    ./hardware.nix
    { _module.args.dotfiles.lib = (import ../../lib) nixpkgs; }
  ];
}

