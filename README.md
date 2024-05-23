# dotfiles

This repo contains the [NixOS](https://github.com/NixOS/nixpkgs) and [Home Manager](https://github.com/nix-community/home-manager) configurations for my workstations and servers.

NixOS and Home Manager allow me to declaratively configure my machines &mdash; enabling reusable and reproducible configurations, and easy rollbacks.

## Getting Started

The following instructions assume you're using NixOS. You can still use the home-manager configurations if you're using a different OS &mdash; instructions for this use case will be added below in the future.

1. clone this repo
2. symlink your `/etc/nixos/` folder to the cloned repo
3. run `sudo nixos-rebuild test --flake .#<hostname>` &mdash; where `<hostname>` is the name of the host configuration you'd like to apply &mdash; from the root of the cloned repo to temporarily apply the configurations
4. once happy with the changes, use `sudo nixos-rebuild switch --flake .#<hostname>` to apply the configurations as a new system generation

Afterward, you won't need to include `--flake .#<hostname>` in the `nixos-rebuild` commands (unless you want to use a different `<hostname>`).

## Planned Improvements

See this repo's [issues](https://github.com/callumcurtis/dotfiles/issues) for plans on improvements to the configurations.

## Troubleshooting

**"no space left on device"**

If you get a "no space left on device" error message indicating a full boot drive when attempting to run a `nixos-rebuild switch` command, you may need to remove old/unused linux kernels from `/boot/EFI/nixos`. Make sure to leave the kernel used by the current system generation intact.

