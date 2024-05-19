{ nixpkgs, home-manager, dotfiles, ... }:

nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = { inherit dotfiles; };
  modules = [
    home-manager.nixosModules.home-manager
    ./system.nix
    ./hardware.nix
    ../../roles
    ../../devices
  ];
}

