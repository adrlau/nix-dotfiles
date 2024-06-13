{
  description = "My System flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    ozai.url = "git+https://git.pvv.ntnu.no/Projects/ozai.git";
    ozai.inputs.nixpkgs.follows = "unstable";
    ozai-webui.url = "git+https://git.pvv.ntnu.no/adriangl/ozai-webui.git";
    ozai-webui.inputs.nixpkgs.follows = "unstable";

    matrix-synapse-next.url = "github:dali99/nixos-matrix-modules";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  

  };

  outputs = {
    self
    , home-manager
    , matrix-synapse-next
    , ozai
    , ozai-webui
    , nix-minecraft
    , nixpkgs
    , sops-nix
    , nixos-hardware
    , unstable
  , ... }@inputs:
    let
      overlay-unstable = final: prev: {
        unstable = unstable.legacyPackages.${prev.system};
      };
    in
    {
      nixosConfigurations = {
        

        eowyn = nixpkgs.lib.nixosSystem {
          system = "x84_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            # Overlays-module makes "pkgs.unstable" available in configuration.nix
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
            ./machines/eowyn/configuration.nix
            sops-nix.nixosModules.sops
            nixos-hardware.nixosModules.dell-latitude-7280
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."gunalx" = import ./home/full.nix;
           }

          ];
        };
   
       aragon = nixpkgs.lib.nixosSystem {
          system = "x84_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            # Overlays-module makes "pkgs.unstable" available in configuration.nix
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
            ./machines/aragon/configuration.nix
            sops-nix.nixosModules.sops
          ];
        };
        

        galadriel = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            # Overlays-module makes "pkgs.unstable" available in configuration.nix
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
            ./machines/galadriel/configuration.nix
            sops-nix.nixosModules.sops

            ozai.nixosModules.ozai
            ozai-webui.nixosModules.ozai-webui
          ];
        };
        

       elrond = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./machines/elrond/configuration.nix
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
            sops-nix.nixosModules.sops
          ];
        };
      };

     
      devShells.x86_64-linux = {
        default = nixpkgs.legacyPackages.x86_64-linux.callPackage ./home/shell.nix { };
      };

      devShells.aarch64-linux = {
        default = nixpkgs.legacyPackages.aarch64-linux.callPackage ./home/shell.nix { };
      };
    };
}




















































































































