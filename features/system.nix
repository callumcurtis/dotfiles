{ dotfiles, ... }:

{
  imports = dotfiles.lib.findMatchingFilesInDirectChildDirectories ./. "system.nix";
}

