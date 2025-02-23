{
  description = "A very basic flake";

  inputs  = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    home-manager = {
       url = "github:nix-community/home-manager/master";
       inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {                                                             # OpenGL
        url = "github:guibou/nixGL";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      emacs-overlay = {                                                     # Emacs Overlays
        url = "github:nix-community/emacs-overlay";
        flake = false;
      };

      doom-emacs = {                                                        # Nix-community Doom Emacs
         url = "github:nix-community/nix-doom-emacs";
         inputs.nixpkgs.follows = "nixpkgs";
         inputs.emacs-overlay.follows = "emacs-overlay";
      };

      hyprland = {                                                          # Official Hyprland flake
        url = "github:vaxerski/Hyprland";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      discord-overlay.url = "github:InternetUnexplorer/discord-overlay";
      discord-overlay.inputs.nixpkgs.follows = "nixpkgs";
      nix-ld.url = "github:Mic92/nix-ld";
      nix-ld.inputs.nixpkgs.follows = "nixpkgs";
    };

  outputs = { self, nixpkgs, nixpkgs-master, home-manager, nixgl, emacs-overlay ,doom-emacs, hyprland, discord-overlay, nix-ld,  ... }:
     let   
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
     };
      
      lib = nixpkgs.lib;
      in {
         nixosConfigurations = {
           forgondolin = lib.nixosSystem {
             inherit system;
             modules = [ 
               ./hosts/configuration.nix
      ({ ... }: { nixpkgs.overlays = [ discord-overlay.overlays.default ]; })
                home-manager.nixosModules.home-manager{
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.forgondolin = {
                  imports = [ ./home.nix ];
                };
       }
      nix-ld.nixosModules.nix-ld
      ];
    };
   };
  };
}
