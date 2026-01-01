{ nixpkgs, nixpkgs-unstable, home-manager, stylix, dotfiles, ... }:

nixpkgs.lib.nixosSystem rec {
  system = "x86_64-linux";
  # Allows use of the dotfiles argument outside of config blocks in nixos modules.
  specialArgs = { inherit dotfiles; };
  modules = [
    home-manager.nixosModules.home-manager
    stylix.nixosModules.stylix
    ../common.nix
    ./system.nix
    ./hardware.nix
    # Allows use of the given arguments outside of config blocks in home-manager modules.
    { home-manager.extraSpecialArgs = specialArgs; }
    ({ config, pkgs, ... }:
      {
        nixpkgs.overlays = [
          (final: prev: {
            unstable = import nixpkgs-unstable {
              inherit (final) system config;
            };
          })
        ];
      }
    )
  ];
}

