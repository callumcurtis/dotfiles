{ nixpkgs, home-manager, nixvim, dotfiles, ... }:

nixpkgs.lib.nixosSystem rec {
  system = "x86_64-linux";
  # Allows use of the dotfiles argument outside of config blocks in nixos modules.
  specialArgs = { inherit dotfiles nixvim; };
  modules = [
    home-manager.nixosModules.home-manager
    ../common.nix
    ./system.nix
    ./hardware.nix
    # Allows use of the given arguments outside of config blocks in home-manager modules.
    { home-manager.extraSpecialArgs = specialArgs; }
  ];
}

