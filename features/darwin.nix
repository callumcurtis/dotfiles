{ dotfiles, ... }:

let
  ignores = [
    ./grub
  ];

  allImports = dotfiles.lib.findMatchingFilesInDirectChildDirectories ./. "system.nix";

  filteredImports = builtins.filter
    (path:
      let dirpath = dirOf path;
      in !(builtins.elem dirpath ignores)
    )
    allImports;
in
{
  imports = filteredImports;
}

