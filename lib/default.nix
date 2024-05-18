{ lib, ... }:

{
  options = rec {
    dotfiles.lib = {
      types = {
        option = lib.mkOptionType {
          name = "option";
          description = "option";
          descriptionClass = "noun";
          check = value: lib.isOption value;
        };
      };

      mkFunctionOption = { function, resultType }: lib.mkOption {
        default = function;
        readOnly = true;
        type = lib.types.functionTo resultType;
      };

      mkConstant = dotfiles.lib.mkFunctionOption {
        function = value: lib.mkOption {
          default = value;
          readOnly = true;
          type = lib.types.oneOf [ lib.types.str lib.types.int ];
        };
        resultType = dotfiles.lib.types.option;
      };
    };
  };
}

