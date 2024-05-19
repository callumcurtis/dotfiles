{ lib, ... }:

let
  mkConstantOption = value: lib.mkOption {
    type = lib.types.oneOf [ lib.types.str lib.types.int ];
    default = value;
    readOnly = true;
  };
in {
  options.dotfiles.constants = {
    name.full = mkConstantOption "Callum Curtis";
    email.github.noreply = mkConstantOption "105407637+callumcurtis@users.noreply.github.com";
  };
}

