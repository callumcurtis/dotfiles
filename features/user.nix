{ dotfiles, ... }:

{
  imports = dotfiles.lib.findMatchingFilesInDirectChildDirectories ./. "user.nix";
}

