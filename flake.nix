{
  description = "NixOS and Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:nix-community/stylix/release-25.05";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    stylix.inputs.home-manager.follows = "home-manager";
    wallpapers.url = "github:input-output-hk/empty-flake?rev=2040a05b67bf9a669ce17eca56beb14b4206a99a";
  };

  outputs = { ... }@inputs: let
    hosts = import ./hosts;
    args = inputs // {
      dotfiles.lib = import ./lib inputs;
      dotfiles.wallpapers = inputs.wallpapers;
    };
  in {
    nixosConfigurations.mist = hosts.mist args;
  };
}

