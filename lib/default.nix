{ nixpkgs, ... }:

{
  mkConstantOption = value: nixpkgs.lib.mkOption {
    type = nixpkgs.lib.types.oneOf [ nixpkgs.lib.types.str nixpkgs.lib.types.int ];
    default = value;
    readOnly = true;
  };

  mkBoolOptionWithDefaultTrue = name: nixpkgs.lib.mkOption {
    default = true;
    example = false;
    description = "Whether to enable ${name}.";
    type = nixpkgs.lib.types.bool;
  };

  mkBoolOptionWithDefaultFalse = name: nixpkgs.lib.mkOption {
    default = false;
    example = true;
    description = "Whether to enable ${name}.";
    type = nixpkgs.lib.types.bool;
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

