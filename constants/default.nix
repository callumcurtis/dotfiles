{ lib, ... }:


{
  options.dotfiles.constants = {
    name.full = lib.mkOption {
      type = lib.types.singleLineStr;
      default = "Callum Curtis";
      readOnly = true;
    };
    email.github.noreply = lib.mkOption {
      type = lib.types.singleLineStr;
      default = "105407637+callumcurtis@users.noreply.github.com";
      readOnly = true;
    };
  };
}

