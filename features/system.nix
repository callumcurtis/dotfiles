{ dotfiles, pkgs, ... }:

let
  imports = dotfiles.lib.findMatchingFilesInDirectChildDirectories ./. "system.nix";
in
{
  imports = if pkgs.stdenv.isDarwin then
    (builtins.filter
      (path:
        let dirpath = dirOf path;
        in !(builtins.elem dirpath [
          ./gnome
          ./grub
          ./hyprland
          ./internationalization
          ./networking
          ./printing
          ./ultralightx
        ]))
      imports)
    else imports;
}

