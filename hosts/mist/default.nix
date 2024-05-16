{ ... }:

let
  workstation = import ../../roles/workstation;
in
{
  imports = [ 
    ./hardware.nix
    workstation.system
  ] ++ (with import ../../devices; [
    ultralightx
  ]);

  networking.hostName = "mist"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Canada/Eastern";
  time.hardwareClockInLocalTime = true; # Ensures compatibility with Windows in dual-boot

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.callumcurtis = {
    isNormalUser = true;
    description = "Callum Curtis";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11";
}

