{
  description = "NixOS and Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { ... }@inputs: let
    hosts = import ./hosts;
  in {
    nixosConfigurations.mist = hosts.mist inputs;
  };
}

