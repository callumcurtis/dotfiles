{ lib, ... }:

let
  mkFunctionOption = { function, returnType }: lib.mkOption {
    type = lib.types.functionTo returnType;
    default = function;
    readOnly = true;
  };
in {
  options.dotfiles.lib = rec {

    types = {
      option = lib.mkOptionType {
        name = "option";
        description = "option";
        descriptionClass = "noun";
        check = value: lib.isOption value;
      };
    };

    mkConstantOption = mkFunctionOption {
      function = value: lib.mkOption {
        type = lib.types.oneOf [ lib.types.str lib.types.int ];
        default = value;
        readOnly = true;
      };
      returnType = types.option;
    };
  };
}

