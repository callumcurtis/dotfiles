{
  description = "NixOS and Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { ... }@inputs: let
    hosts = import ./hosts;
    args = inputs // { dotfiles.lib = import ./lib inputs; };
  in {
    nixosConfigurations.mist = hosts.mist args;
  };
}

