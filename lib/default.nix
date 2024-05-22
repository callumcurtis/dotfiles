{ nixpkgs, ... }:

{
  mkConstantOption = value: nixpkgs.lib.mkOption {
    type = nixpkgs.lib.types.oneOf [ nixpkgs.lib.types.str nixpkgs.lib.types.int nixpkgs.lib.types.path ];
    default = value;
    readOnly = true;
  };

  mkTypedOptionWithDefault = type: default: nixpkgs.lib.mkOption {
    type = type;
    default = default;
  };

  mkTypedOption = type: nixpkgs.lib.mkOption {
    type = type;
  };

  findMatchingFilesInDirectChildDirectories = parent: filename: builtins.attrValues (
    nixpkgs.lib.filterAttrs
      (n: v: builtins.pathExists v)
      (builtins.mapAttrs
        (n: v: /${parent}/${n}/${filename})
        (nixpkgs.lib.filterAttrs
          (n: v: nixpkgs.lib.pathIsDirectory /${parent}/${n})
          (builtins.readDir parent)
        )
      )
  );
}

