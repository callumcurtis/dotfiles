{
  description = "NixOS and Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:nix-community/stylix/release-25.11";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    wallpapers.url = "git+ssh://git@github.com/callumcurtis/wallpapers";
    hyprland.url = "github:hyprwm/Hyprland";
    metarepo.url = "github:callumcurtis/metarepo";
    metarepo.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
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

