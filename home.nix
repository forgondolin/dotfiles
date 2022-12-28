{ config, pkgs, lib, ... }:

let

  unstable = import
    (builtins.fetchTarball {
      # url = https://github.com/NixOS/nixpkgs/tarball/f930ea227cecaed1f1bdb047fef54fe4f0721c8c; # nixpkgs-unstable 5 July 2021
      url = https://github.com/NixOS/nixpkgs/tarball/14b0f20fa1f56438b74100513c9b1f7c072cf789; # nixpkgs-unstable 20 Aug 2021
    }) {
      # config.allowBroken = true;
      config.allowUnfree = true;
      nixpkgs.config.allowUnfree = true;
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.opengl.enable = true;
      hardware.nvidia.modesetting.enable = true;
    };
  pkgsUnstable = import <nixpkgs-unstable> {};
  pkgsAuto = import <nixgl> {};
  nix.extraOptions = ''
  experimental-features = nix-command
  '';



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
        pkgsUnstable.morph
        pkgs.texlive.combined.scheme-full
        pkgs.ninja
        pkgs.shadow
	pkgs.qemu
        pkgs.podman
        pkgs.slirp4netns
        pkgs.gnuradio
        pkgs.gpredict
        pkgs._1password-gui
        pkgs.lynx
        pkgs.haskellPackages.xmonad
        pkgs.gum
        pkgs.yarn
        pkgs.obs-studio
        pkgs.niv
        pkgs.nomad
        pkgs.sops
        pkgs.age
        pkgs.ssh-to-age
        pkgs.vim
        pkgs.virtualbox
        pkgs.tilix
	pkgs.vagrant

        #VFX
        pkgs.blender
        pkgs.glxinfo
        pkgs.libGL
        pkgsAuto.auto.nixGLDefault
        pkgs.glibc

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
	      pkgs.gleam
        pkgs.erlang
	      pkgs.rebar3

        # Rust
        pkgs.cargo
        pkgs.rustc

        # Haskell
        # x86.stack

        #Go
        pkgs.go
        pkgs.hugo

        #Games
        pkgs.haxe

        #Dhall
        pkgs.dhall
        pkgs.dhall-json

        #Electronics
        pkgs.fritzing
        pkgs.kicad



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
      direnv.enable = true;
      exa.enable = true;
      fzf = {
       enable = true;
       fileWidgetOptions = [ "--preview 'bat --color always {}'" ];
     };

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


      zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = false;
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
    };


     starship = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = false;
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
