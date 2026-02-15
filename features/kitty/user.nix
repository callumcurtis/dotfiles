{ config, lib, dotfiles, ... }:

{
  options.dotfiles.features.kitty = {
    enable = lib.mkEnableOption "kitty";
    shell = dotfiles.lib.mkTypedOption lib.types.path;
  };

  config = lib.mkIf config.dotfiles.features.kitty.enable {
    programs.kitty = {
      enable = true;
      settings = {
        shell = config.dotfiles.features.kitty.shell;
        cursor_trail = 50;
        cursor_trail_decay = "0.05 0.10";
        confirm_os_window_close = 0;
      };
      keybindings = {
        "cmd+a" = "send_key alt+a";
        "cmd+b" = "send_key alt+b";
        "cmd+c" = "send_key alt+c";
        "cmd+d" = "send_key alt+d";
        "cmd+e" = "send_key alt+e";
        "cmd+f" = "send_key alt+f";
        "cmd+g" = "send_key alt+g";
        "cmd+h" = "send_key alt+h";
        "cmd+i" = "send_key alt+i";
        "cmd+j" = "send_key alt+j";
        "cmd+k" = "send_key alt+k";
        "cmd+l" = "send_key alt+l";
        "cmd+m" = "send_key alt+m";
        "cmd+n" = "send_key alt+n";
        "cmd+o" = "send_key alt+o";
        "cmd+p" = "send_key alt+p";
        "cmd+q" = "send_key alt+q";
        "cmd+r" = "send_key alt+r";
        "cmd+s" = "send_key alt+s";
        "cmd+t" = "send_key alt+t";
        "cmd+u" = "send_key alt+u";
        "cmd+v" = "send_key alt+v";
        "cmd+w" = "send_key alt+w";
        "cmd+x" = "send_key alt+x";
        "cmd+y" = "send_key alt+y";
        "cmd+z" = "send_key alt+z";
        "cmd+0" = "send_key alt+0";
        "cmd+1" = "send_key alt+1";
        "cmd+2" = "send_key alt+2";
        "cmd+3" = "send_key alt+3";
        "cmd+4" = "send_key alt+4";
        "cmd+5" = "send_key alt+5";
        "cmd+6" = "send_key alt+6";
        "cmd+7" = "send_key alt+7";
        "cmd+8" = "send_key alt+8";
        "cmd+9" = "send_key alt+9";
      };
    };
  };
}
