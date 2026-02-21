{ darwin, nixpkgs-unstable, home-manager, stylix, dotfiles, self, nix-homebrew, homebrew-core, homebrew-cask, ... }:

darwin.lib.darwinSystem rec {
  # Allows use of the dotfiles argument outside of config blocks in darwin modules.
  specialArgs = { inherit dotfiles self homebrew-core homebrew-cask; isNixos = false; isDarwin = true; };
  modules = [
    home-manager.darwinModules.home-manager
    stylix.darwinModules.stylix
    nix-homebrew.darwinModules.nix-homebrew
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
              inherit (final) config;
              system = final.stdenv.hostPlatform.system;
            };
          })
        ];
      }
    )
  ];
}

