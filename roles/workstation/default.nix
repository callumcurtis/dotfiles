{ config, lib, pkgs, ... }:

let
  hm = {
    fonts.fontconfig.enable = true;

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        document-font-name = "Liberation Sans 10";
        font-name = "Liberation Sans 10";
        monospace-font-name = "Liberation Mono 9";
     };
    };

    home.packages = with pkgs; [
      lunarvim
      google-chrome
      (pkgs.nerdfonts.override { fonts = ["FiraMono"]; })
    ];

    programs.fish = {
      enable = true;
      functions = {
        fish_greeting = "";
      };
    };

    programs.zoxide.enable = true;

    programs.starship.enable = true;

    programs.zellij = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        default_shell = "${pkgs.fish}/bin/fish";
        theme = "tokyo-night-dark";
        default_layout = "compact";
        pane_frames = false;
      };
    };

    programs.eza = {
      enable = true;
      icons = true;
      git = true;
    };

    programs.git = {
      enable = true;
      userName = "Callum Curtis";
      userEmail = "105407637+callumcurtis@users.noreply.github.com";
      extraConfig = {
        rerere.enabled = true;
        init.defaultBranch = "main";
      };
      delta = {
        enable = true;
        options = {
          side-by-side = true;
        };
      };
    };

    programs.kitty = {
      enable = true;
      font = {
        name = "FiraMono Nerd Font";
        size = 10;
      };
      theme = "Tokyo Night Moon";
      settings = {
        shell = "${pkgs.fish}/bin/fish";
      };
    };

    home.sessionVariables = {
      EDITOR = "${pkgs.lunarvim}/bin/lvim";
    };

    # This value determines the home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update home Manager without changing this value. See
    # the home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "23.11";

    # Let home Manager install and manage itself.
    programs.home-manager.enable = true;
  };

  userOptions = { ... }: {
    options = {
      enable = lib.mkEnableOption "workstation user";
    };
  };

  enabledUsers = (
    builtins.listToAttrs (
      builtins.filter
        (pair: pair.value.enable)
        (builtins.map
          (user: { name = user; value = config.dotfiles.roles.workstation.users.${user}; })
          (builtins.attrNames config.dotfiles.roles.workstation.users)
        )
    )
  );
in
{
  options.dotfiles.roles.workstation.users = lib.mkOption {
    default = {};
    type = lib.types.attrsOf (lib.types.submodule userOptions);
  };

  config = lib.mkIf (enabledUsers != {}) {
    home-manager.users = builtins.mapAttrs (user: options: hm) enabledUsers;

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
    programs.fish.enable = true; # Enable vendor completions provided by nixpgs
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

