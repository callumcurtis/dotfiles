{ nixpkgs, home-manager, stylix, dotfiles, hyprland, ... }:

nixpkgs.lib.nixosSystem rec {
  system = "x86_64-linux";
  # Allows use of the dotfiles argument outside of config blocks in nixos modules.
  specialArgs = { inherit dotfiles; inherit hyprland; };
  modules = [
    home-manager.nixosModules.home-manager
    stylix.nixosModules.stylix
    ../common.nix
    ./system.nix
    ./hardware.nix
    # Allows use of the given arguments outside of config blocks in home-manager modules.
    { home-manager.extraSpecialArgs = specialArgs; }
  ];
}

