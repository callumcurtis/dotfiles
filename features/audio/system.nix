{ config, lib, ... }:

{
  options.dotfiles.features.audio.enable = lib.mkEnableOption "audio";

  config = lib.mkIf config.dotfiles.features.audio.enable {
    # Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
