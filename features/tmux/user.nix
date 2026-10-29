{ config, lib, dotfiles, pkgs, ... }:

let
  cfg = config.dotfiles.features.tmux;
  tmux = "${config.programs.tmux.package}/bin/tmux";

  # Runs in Alt-s's popup: opens the whole scrollback of the pane underneath in Neovim, as a scratch buffer (no file
  # tree, nothing to save) with the cursor on the last non-blank line
  editScrollback = pkgs.writeShellScript "tmux-edit-scrollback" ''
    file=$(mktemp)
    ${tmux} capture-pane -J -p -S - -t "$(${tmux} display -p '#{pane_id}')" \
      | awk '{ lines[NR] = $0 } NF { last = NR } END { for (i = 1; i <= last; i++) print lines[i] }' > "$file"
    "''${EDITOR:-nvim}" + -c 'setlocal buftype=nofile' "$file"
    rm -f "$file"
  '';
in
{
  options.dotfiles.features.tmux = {
    enable = lib.mkEnableOption "tmux";
    shell = dotfiles.lib.mkTypedOption lib.types.path;
    autoStartIn.fish = dotfiles.lib.mkTypedOptionWithDefault lib.types.bool true;
  };

  config = lib.mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      shell = "${cfg.shell}";
      terminal = "tmux-256color";
      escapeTime = 0;
      historyLimit = 100000;
      mouse = true;
      keyMode = "vi";
      baseIndex = 1;
      focusEvents = true;
      # After the theme (Stylix), so this config's styles win
      extraConfig = lib.mkAfter (builtins.replaceStrings
        [ "@active_background@" "@inactive_background@" "@edit_scrollback@" ]
        [
          config.dotfiles.features.stylix.activeBackground
          config.dotfiles.features.stylix.inactiveBackground
          "${editScrollback}"
        ]
        (builtins.readFile ./tmux.conf));
    };

    # Attach interactive fish shells that aren't already inside tmux to the single "main" session, creating it if
    # needed; quitting or detaching from tmux returns to fish
    programs.fish.interactiveShellInit = lib.mkIf cfg.autoStartIn.fish ''
      if not set -q TMUX
        ${tmux} new-session -A -s main
      end
    '';

    home.shellAliases = {
      rnt = "tmux rename-window";
      rnp = "tmux select-pane -T";
    };
  };
}
