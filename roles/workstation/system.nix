{ config, lib, pkgs, ... }:

{
  imports = [
    ../../features/system.nix
  ];

  options.dotfiles.system.roles.workstation.enable = lib.mkEnableOption "workstation role";

  config = lib.mkIf (config.dotfiles.system.roles.workstation.enable) {

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

    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

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

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
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

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # Enable flakes.
    nix.settings.experimental-features = ["nix-command" "flakes"];
  };
}

