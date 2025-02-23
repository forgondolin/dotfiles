{ config, pkgs, lib,  ... }:

let 
  unstable = import <nixos-unstable> {};
in
{

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
    (self: super: {
      emacsGit = super.emacsGit.override {
        withXwidgets = true;
        withGTK3 = true;
      };
    })
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "forgondolin";
  home.homeDirectory = "/home/forgondolin";
 
 home.packages = [
    pkgs.fortune
    pkgs.fd
    pkgs.ripgrep
    pkgs.git
    pkgs.haxe
    pkgs.neofetch
    pkgs.go
    pkgs.rustc
    pkgs.cargo
    pkgs.ocaml
    pkgs.postman
    pkgs.kubo
    pkgs.steam-run
    pkgs.gcc
    pkgs.pulumi
    pkgs.inetutils
    pkgs.guvcview
    pkgs.emacsPackages.xwidgete
    pkgs.nodejs
    pkgs.vscode
    pkgs.lutris
    pkgs.dxvk
    pkgs.niv
    pkgs.dbeaver
    pkgs.vlc
    pkgs.protonvpn-gui
    pkgs.python39
    pkgs.python311Packages.pip
    pkgs.flyctl
    pkgs.elixir_1_15
    pkgs.lld
    pkgs.rustup-toolchain-install-master
    pkgs.libGL
    pkgs.obsidian
    #nvidia
    


    #Gaming
    pkgs.godot_4
    pkgs.yuzu-early-access
    #Network
    pkgs.nmap
    pkgs.wireshark
    pkgs.htop  
    pkgs.snort
	    
    #Edition
    pkgs.gimp
    pkgs.obs-studio
    pkgs.cudaPackages.cudatoolkit

    pkgs.pulseaudio
    
    #Music
    pkgs.vcv-rack
    pkgs.libjack2
    pkgs.audacity
    unstable.cardinal
 ];


home.sessionPath = [
    "$HOME/.cargo/bin"
    "$HOME/.emacs.d/bin"
    "$HOME/.go/bin"
    "$HOME/.local/bin"
  ];

home.sessionVariables = {
  EDITOR = "emacs";
  LANG = "pt_BR.UTF-8";
  LC_ALL = "pt_BR.UTF-8";
  LANGUAGE = "pt_BR:en_US";

  NIX_LD_LIBRARY_PATH = with pkgs;
      lib.makeLibraryPath [
        stdenv.cc.cc
        zlib
        fuse3
        icu
        zlib
        nss
        openssl
        curl
        expat
      ];

    NIX_LD = builtins.readFile "${pkgs.stdenv.cc}/nix-support/dynamic-linker";
};

home.stateVersion = "23.05";



programs.home-manager.enable = true;
 services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

 programs.zsh = {
    enable = true;
    enableCompletion = false;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
       rb = "sudo nixos-rebuild switch --flake .#forgondolin"; };

    initExtraBeforeCompInit = builtins.readFile ./modules/shell/zshrc;
    oh-my-zsh = {
      enable = true;
      theme = "af-no-magic";
      plugins = [
        "git"
        "tmuxinator"
        "nix-shell"
        "direnv"
        "aws"
        "docker"
        "encode64"
      ];
    };
  };

home.file.".doom.d" = {
    onChange = ''
      #!/bin/sh
      emacs="$HOME/.emacs.d/bin"
      DOOM="$HOME/.emacs.d"
      if [ ! -d "$DOOM" ]; then
        git clone git@github.com:doomemacs/doomemacs.git $HOME/.emacs.d
        $DOOM/bin/doom -y install
      fi

     # $DOOM/bin/doom sync
    '';
    source = ./doom.d;
    recursive = true;
  };

  programs.emacs = {
      enable = true;
     # package = (pkgs.emacsGit.override {
     # withXwidgets = true;
   # });
     package = pkgs.emacs-nox;
     extraPackages = epkgs: [ epkgs.vterm epkgs.xwidgets-reuse ];
 };
  
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
      settings = {
         format = "$shlvl$shell$username$hostname$nix_shell$git_branch$git_commit$git_state$git_status$directory$jobs$cmd_duration$character";
           username = {
             style_user = "bright-white bold";
             style_root = "bright-red bold";
          };

         character = {
         success_symbol = "[➜](bold green)";
         error_symbol = "[➜](bold red)";
    };
  };
};
  
        programs.git = {
        enable    = true;
        userName  = "Kaleb Alves";
        userEmail = "kaleblucasalves@hotmail.com";
 
        signing = {
          key           = "";
          signByDefault = false;
        };
     };

  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

  home.file.".config/oh-my-zsh/themes/af-no-magic.zsh-theme".source = ./modules/shell/af-no-magic.zsh-theme;
services.emacs={ 
  enable = true;   
 };
}
