{
  description = "NixOS and Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:nix-community/stylix/release-26.05";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    wallpapers.url = "git+ssh://git@github.com/callumcurtis/wallpapers";
    hyprland.url = "github:hyprwm/Hyprland";
    metarepo.url = "github:callumcurtis/metarepo";
    metarepo.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { ... }@inputs: let
    hosts = import ./hosts;
    args = inputs // {
      dotfiles.lib = import ./lib inputs;
      dotfiles.wallpapers = inputs.wallpapers;
      dotfiles.hyprland = inputs.hyprland;
      dotfiles.metarepo = inputs.metarepo;
    };
  in {
    nixosConfigurations = {
      mist = hosts.mist args;
      wind = hosts.wind args;
    };
    darwinConfigurations = {
      gale = hosts.gale args;
    };
  };
}

