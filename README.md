# dotfiles

This repo contains the [NixOS](https://github.com/NixOS/nixpkgs) and [Home Manager](https://github.com/nix-community/home-manager) configurations for my workstations and servers.

NixOS and Home Manager allow me to declaratively configure my machines - enabling reusable and reproducible configurations, and easy rollbacks.

## TODO

### MUST

- [x] (a bunch of other things I did before creating this list)
- [x] setup ssh
- [x] use nixpkg path interpolations rather than names of binaries
- [ ] modularize the system (nixos) and user (home manager) configurations
- [ ] experiment with creating development shells for projects using [nix-shell](https://nixos.org/manual/nix/stable/command-ref/nix-shell)
- [ ] [nix-ld](https://github.com/Mic92/nix-ld): un-nix-like, but may simplify running some binaries
- [ ] [starship](https://github.com/starship/starship): shell prompt

### SHOULD

- [ ] [agenix](https://github.com/ryantm/agenix): managing secrets (Spotify, ...)
- [ ] [spotifyd](https://github.com/Spotifyd/spotifyd): music
- [ ] commit signing
- [ ] bill of tools and keybindings: so that I can review my setup in case I forget
- [ ] [rclone](https://github.com/rclone/rclone): file syncing for cloud storage
- [ ] [git-cliff](https://github.com/orhun/git-cliff): for generating changelogs for my projects using conventional commits (make project-specific using nix-shells)
- [ ] [bat](https://github.com/sharkdp/bat): better cat
- [ ] [impermanence](https://github.com/nix-community/impermanence): ensures clean and declarative system

### COULD (for Awareness or Ricing)

- [ ] [nushell](https://github.com/nushell/nushell)
- [ ] [btop](https://github.com/aristocratos/btop): resource monitoring
- [ ] [neofetch](https://github.com/dylanaraps/neofetch)
- [ ] [hyprland](https://github.com/hyprwm/Hyprland): wayland desktop environment
- [ ] custom grub theme (background image, fixed text)

