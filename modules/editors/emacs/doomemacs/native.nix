#
# Doom Emacs: home-manager alternative below. Personally not a fan of github:nix-community/nix-doom-emacs due to performance issues
# Recommended to comment out this import first install because script will cause issues. It your want to use doom emacs, use the correct location or change in script
#
# flake.nix
#   ├─ ./hosts
#   │   └─ configuration.nix
#   └─ ./modules
#       └─ ./editors
#           └─ ./emacs
#               └─ default.nix *
#


{ config, pkgs, lib, ... }:

{
  services.emacs.enable = false;

#  system.userActivationScripts = {               # Installation script every time nixos-rebuild is run. So not during initial install.
#    doomEmacs = {
#      text = ''
#        source ${config.system.build.setEnvironment}
#        DOOM="$HOME/.emacs.d"

#        if [ ! -d "$DOOM" ]; then
#          git clone https://github.com/hlissner/doom-emacs.git $DOOM
#          yes | $DOOM/bin/doom install
#          rm -r $HOME/.doom.d
#          ln -s ./modules/editors/emacs/doom.d $HOME/.doom.d
#          $DOOM/bin/doom sync
#        else
#          $DOOM/bin/doom sync
#        fi
#      '';                                        # It will always sync when rebuild is done. So changes will always be applied.
#    };
#  };

#home.nix adaptation

#home.file.".doom.d" = {
 #   onChange = ''
      #!/bin/sh
#      DOOM=$HOME/.emacs.d
 #     if [ ! -d $DOOM ]; then
 #       git clone --depth 1 https://github.com/hlissner/doom-emacs $DOOM
 #     fi
 #   '';
 #   source = ./modules/editors/emacs/doomemacs/doom.d;
 #   recursive = true;
 # };

 # programs = {
 #   emacs = {
 #     enable = true;
 #     package = pkgs.emacs-nox;
  #    extraPackages = epkgs: [ epkgs.vterm ];
   # };
 # };
#}

#hosts/configuration.nix version

#  environment.systemPackages = with pkgs; [
    #emacs
#    ripgrep
#    coreutils
#    fd
#  ];                                             # Dependencies
#}

# HOME MANAGER ALTERNATIVE

#{ pkgs, ... }:

#{
#  home.file.".doom.d" = {                       # Get Doom Emacs
#    source = ./doom.d;                          # Sets up symlink name ".doom.d" for file "doom.d"
#    recursive = true;                           # Allow symlinking a directory
#    onChange = builtins.readFile ./doom.sh;     # If an edit is detected, it will run this script. Pretty much the same as what is now in default.nix but actually stating the terminal and adding the disown flag to it won't time out
#  };

#  programs = {
#    emacs.enable = true;                        # Get Emacs
#  };
#}

# REFERENCES ./doom.d DIRECTORY

# doom.sh:
#
# #!/bin/sh
# DOOM="$HOME/.emacs.d"
#
# if [ ! -d "$DOOM" ]; then
#   git clone https://github.com/hlissner/doom-emacs.git $DOOM
#   alacritty -e $DOOM/bin/doom -y install & disown
# else
#   alacritty -e $DOOM/bin/doom sync
# fi
#
