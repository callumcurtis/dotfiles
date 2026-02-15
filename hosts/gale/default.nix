{ darwin, nixpkgs-unstable, home-manager, stylix, dotfiles, self, ... }:

darwin.lib.darwinSystem rec {
  # Allows use of the dotfiles argument outside of config blocks in darwin modules.
  specialArgs = { inherit dotfiles self; isDarwin = true; };
  modules = [
    home-manager.darwinModules.home-manager
    stylix.darwinModules.stylix
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

