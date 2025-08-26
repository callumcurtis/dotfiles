{ nixpkgs, home-manager, stylix, dotfiles, ... }:

let
  system = "aarch64-darwin";
in
  home-manager.lib.homeManagerConfiguration {
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;

      # The default node version, 20.19.0, has failing tests on stable nixpkgs: https://github.com/NixOS/nixpkgs/issues/402079
      # This overlay changes the default node version to avoid this error
      # TODO: remove the node version overlays below when nixpkgs #402079 is fixed
      overlays = [
        (self: super: {
          nodejs = super.nodejs_22;
          nodejs-slim = super.nodejs-slim_22;
        })
      ];
    };

    # Allows use of the dotfiles argument outside of config blocks in nixos modules.
    extraSpecialArgs = { inherit dotfiles; };

    modules = [
      stylix.homeManagerModules.stylix
      ./user.nix
    ];
  }

