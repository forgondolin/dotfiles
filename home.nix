{ config, pkgs, ... }:

let

  unstable = import
    (builtins.fetchTarball {
      # url = https://github.com/NixOS/nixpkgs/tarball/f930ea227cecaed1f1bdb047fef54fe4f0721c8c; # nixpkgs-unstable 5 July 2021
      url = https://github.com/NixOS/nixpkgs/tarball/14b0f20fa1f56438b74100513c9b1f7c072cf789; # nixpkgs-unstable 20 Aug 2021
    }) {
      # config.allowBroken = true;
      config.allowUnfree = true;
    };

  pkgsUnstable = import <nixpkgs-unstable> {};

in
  {
    home = {
         homeDirectory = "/home/forgondolin";
       packages = [
       # Utilidades
        pkgs.git
        pkgs.gitAndTools.gh
        pkgs.awscli2
        pkgs.pulumi-bin
        pkgs.neofetch
        pkgs.coreutils
        pkgs.direnv
        pkgs.speedtest-cli
        pkgs.wget
       # pkgs.zsh-powerlevel10k
       # pkgs.zsh
       # pkgs.meslo-lgs-nf
        pkgsUnstable.morph

        #CUE
        pkgs.cue

        # Process
        pkgs.htop
        pkgs.lsof

        # FS
        pkgs.ripgrep
        pkgs.tree

        # Data
        unstable.ipfs

        # BEAM
        pkgs.elixir

        # Rust
        pkgs.cargo
        pkgs.rustc

        # Haskell
        # x86.stack

        #Go
        pkgs.go

        #Dhall
        pkgs.dhall
        pkgs.dhall-json

        # Editor
       # unstable.emacs
       # doom-emacs
        # unstable.haskell-language-server
      ];

      # file.".emacs.d/init.el".text = ''
      #   (lIoad "default.el")
      # '';

    stateVersion = "22.05";
    username = "forgondolin";
    
    sessionPath = [
    "$HOME/.cargo/bin"
    "$HOME/.emacs.d/bin"
    "$HOME/.go/bin"
    "$HOME/.local/bin"
  ];    
    
    file.".doom.d" = {
    onChange = ''
      #!/bin/sh
      DOOM="$HOME/.emacs.d"
      if [ ! -d "$DOOM" ]; then
        git clone git@github.com:doomemacs/doomemacs.git $HOME/.emacs.d
        $DOOM/bin/doom -y install
      fi
      $DOOM/bin/doom sync
    '';
    source = ./doom.d;
    recursive = true;
  };

};

    programs = {
      autojump.enable = true;
      bat.enable      = true;
      home-manager.enable = true;
     #  direnv = {
     #    enable = true;
     #    enableNixDirenvIntegration = true;
     #    #  nix-direnv = {
     #    #    enable = true;
     #    #    enableFlakes = true;
     #    #  };
     #  };
     tmux = {
        enable = true;
        baseIndex = 1;
        historyLimit = 100500;
        keyMode = "emacs";
        extraConfig = ''
          unbind C-Space
          set -g prefix C-Space
          bind C-Space send-prefix
          set -g status off
        '';
        plugins = [ pkgs.tmuxPlugins.yank ];
      };

     fish = {
       enable = true;

     };

/*
      zsh = {
        enable = true;
        enableAutosuggestions = true;
      enableCompletion = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "bundler"
          "direnv"
          "docker"
          "docker-compose"
          "git"
          "golang"
          "mix"
          "rails"
          "ssh-agent"
          "tmux"
        ];
      };
      sessionVariables = {
        EDITOR = "vim";
        GOPATH = "$HOME/.go";
      };
      shellAliases = {
        ls = "exa --git";
        ll = "exa -lh --git";
      };
    };
      */

     starship = {
      enable = true;
      enableZshIntegration = false;
      enableFishIntegration = true;
      settings = {
        character = {
          success_symbol = "[»](bold green) ";
          error_symbol = "[✗](bold red) ";
        };
        directory = {
          fish_style_pwd_dir_length = 1;
          truncation_length = 1;
        };
        hostname = {
          ssh_only = false;
          format = "[$hostname]($style):";
        };
        gcloud = { disabled = true; };
        kubernetes = { disabled = false; };
        username = { format = "[$user]($style)@"; };
      };
    };

      emacs = {
      enable = true;
      package = pkgs.emacs-nox;
      extraPackages = epkgs: [ epkgs.vterm ];
    };
 

      dircolors = {
        enable = true;
        enableFishIntegration = true;
      };


      git = {
        enable    = true;
        userName  = "Kaleb Alves";
        userEmail = "kaleblucasalves@hotmail.com";
 
        signing = {
          key           = "";
          signByDefault = false;
        };


        extraConfig = {
          core.editor        = "vim";
          github.user        = "forgondolin";
          init.defaultBranch = "main";
          pull.rebase        = true;
        };
      };
    };

    services = {
      emacs = {
         enable = true;   
        };
    
  };
    
 }
