{ dotfiles, ... }:

let
  ignores = [
    ./grub
  ];

  allImports = dotfiles.lib.findMatchingFilesInDirectChildDirectories ./. "system.nix";

  filteredImports = builtins.filter
    (path:
      let dirname = baseNameOf (dirOf path);
      in !(builtins.elem dirname ignores)
    )
    allImports;
in
{
  imports = filteredImports;
}

