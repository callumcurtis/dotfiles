{ lib, ... }:

{
  mkConstant = value: lib.mkOption {
    default = value;
    readOnly = true;
    type = lib.types.oneOf [ lib.types.str lib.types.int ];
  };
}

