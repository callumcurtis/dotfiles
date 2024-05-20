{ config, lib, pkgs, ... }:

{
  imports = [
    ../../features/system.nix
    ../../lib
    ../../constants
  ];

  options.dotfiles.system.roles.workstation.enable = lib.mkEnableOption "workstation role";

  config = lib.mkIf (config.dotfiles.system.roles.workstation.enable) {

    dotfiles.features.networking.enable = true;
    dotfiles.features.printing.enable = true;
    dotfiles.features.audio.enable = true;
    dotfiles.features.flakes.enable = true;
    dotfiles.features.ssh.enable = true;
    dotfiles.features.fish.enable = true;

    # Apply selected overlays to nixpkgs.
    nixpkgs.overlays = with import ../../overlays; [
      poly-dark-grub-theme
    ];

    # Configure bootloader.
    boot.loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        theme = pkgs.poly-dark-grub-theme;
        font = "${pkgs.poly-dark-grub-theme}/font.otf";
        fontSize = 48;
      };
    };

    # Set global Home Manager settings.
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    # Enable the X11 windowing system.
    services.xserver.enable = true;
    services.xserver.excludePackages = with pkgs; [ xterm ];

    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    environment.gnome.excludePackages = with pkgs; [ gnome-console ];

    # Configure keymap in X11
    services.xserver = {
      layout = "us";
      xkbVariant = "";
    };    

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # System programs
    programs.nix-ld.enable = true; # Enable running unpatched binaries (simplifies using pip and other package managers)

    # System packages
    environment.systemPackages = with pkgs; [
      xclip
    ];
  };
}

