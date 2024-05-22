{ dotfiles, pkgs, ... }:

let
  mk = dotfiles.lib.mkConstantOption;
in {
  options.dotfiles.constants = {
    name.full = mk "Callum Curtis";
    email.github.noreply = mk "105407637+callumcurtis@users.noreply.github.com";
    timeZone = mk "Canada/Eastern";
    locale = mk "en_CA.UTF-8";
    shell = mk "${pkgs.fish}/bin/fish";
  };
}

