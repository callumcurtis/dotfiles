# dotfiles

This repo contains the [NixOS](https://github.com/NixOS/nixpkgs) and [Home Manager](https://github.com/nix-community/home-manager) configurations for my workstations and servers.

NixOS and Home Manager allow me to declaratively configure my machines &mdash; enabling reusable and reproducible configurations, and easy rollbacks.

## Getting Started

The following instructions assume you're using NixOS. You can still use the home-manager configurations if you're using a different OS &mdash; instructions for this use case will be added below in the future.

1. clone this repo
2. symlink your `/etc/nixos/` folder to the cloned repo
3. update the [defaults](./constants/default.nix) as you like
3. run `sudo nixos-rebuild test --flake .#<hostname> --override-input wallpapers <input>`
&mdash; where `<hostname>` is the name of the host configuration you'd like to apply
and `<input>` is an input specifier for your wallpapers &mdash;
from the root of the cloned repo to temporarily apply the configurations
4. once happy with the changes, use
`sudo nixos-rebuild switch --flake .#<hostname> --override-input wallpapers <input>`
to apply the configurations as a new system generation

Afterward, you won't need to include `--flake .#<hostname>` in the `nixos-rebuild`
commands (unless you want to use a different `<hostname>`).

## Useful (But Excluded) Utilities

Utilities for development have been excluded from these dotfiles. This way, project flakes are responsible
for defining their own utilities. For example, `btop` is included in these dotfiles as it is useful in multiple contexts,
even outside of development, whereas `hyperfine` has been excluded as it is typically used to benchmark a project during
development, and is better defined in the project's flake.

- [entr](https://github.com/eradman/entr): run arbitrary commands when files change
- [flamegraph](https://github.com/callumcurtis/snippets/tree/main/topic/profiling/flamegraph): opinionated stack trace visualizer
- [hyperfine](https://github.com/sharkdp/hyperfine): command-line benchmarking tool

## Planned Improvements

See this repo's [issues](https://github.com/callumcurtis/dotfiles/issues) for plans on improvements to the configurations.

## Useful Keymaps

### In Neovim

- `s<query>`: jump to query position
- `cr<query>`: start `c` at query position
- `vS`: start `v` using Treesitter selection
- `vR<query>`: start `v` using Treesitter selection at query position

## Troubleshooting

**"no space left on device"**

If you get a "no space left on device" error message indicating a full boot drive when attempting to run a `nixos-rebuild switch` command, you may need to remove old/unused linux kernels from `/boot/EFI/nixos`. Make sure to leave the kernel used by the current system generation intact.

**boot manager disappears**

This will happen occasionally when dual-booting with Windows, as Windows updates may mess with your EFI partition and cause the NixOS boot manager to disappear.

1. [Download](https://nixos.org/download/) a minimal ISO image for NixOS
2. [Copy](https://nixos.org/manual/nixos/stable/#sec-booting-from-usb-linux) the ISO onto a thumb-drive
  ```
  sudo dd if=<path-to-image> of=/dev/<device> bs=4m
  ```
3. Insert the thumb-drive into the computer that you want to recover the boot manager on and swap the boot order in your BIOS to prioritize the thumb-drive
4. Select the Linux LTS version in the live USB
5. [Mount](https://nixos.wiki/wiki/Bootloader#Re-installing_the_bootloader) your boot and root partitions to the live USB environment
  ```
  sudo mkdir -p /mnt/boot
  sudo mount /dev/<root-partition> /mnt
  sudo mount /dev/<efi-partition> /mnt/boot
  ```
6. [Enter](https://nixos.wiki/wiki/Bootloader#Re-installing_the_bootloader) your NixOS installation from the live USB environment
  ```
  nixos-enter
  ```
7. [Re-install](https://nixos.wiki/wiki/Bootloader#Re-installing_the_bootloader) the bootloader
  ```
  NIXOS_INSTALL_BOOTLOADER=1 /nix/var/nix/profiles/system/bin/switch-to-configuration boot
  ```
8. Exit the chroot environment created by `nixos-enter` and reboot
  ```
  <CTRL-D>
  reboot
  ```
9. During startup, enter your BIOS and swap the boot order to prioritize the NixOS boot manager, which should now appear as an option
10. Enter your recovered NixOS installation, and run another `nixos-rebuild switch` (or just `./switch` if using these dotfiles) to apply your custom
  boot manager configuration (which will also add Windows to your NixOS boot manager options if you have enabled OS probing)

