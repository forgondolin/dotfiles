#
# Doom Emacs: home-manager alternative in "native.nix". Personally not a fan of github:nix-community/nix-doom-emacs due to performance issues
#
# flake.nix
#   ├─ ./hosts
#   │   └─ configuration.nix
#   └─ ./modules
#       └─ ./editors
#           └─ ./emacs
#               └─ default.nix *
#


{ config, pkgs, ... }:

{
  services.emacs = {
    enable = true;
  };

  programs.emacs = {
    enable = true;
  };

  home = {
    #packages = with pkgs; [
    #  ripgrep
    #  coreutils
    #  fd
    #];
    activation = {
      emacs = ''
        CONFIG="$HOME/.emacs.d"

        if [ ! -d "$CONFIG" ]; then
          git clone https://github.com/matthiasbenaets/emacs.d.git $CONFIG
        fi
      '';
    };
  };
}
