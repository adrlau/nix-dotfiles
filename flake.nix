{
  description = "My System flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    matrix-synapse-next.url = "github:dali99/nixos-matrix-modules";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self
    , home-manager
    , matrix-synapse-next
    , nix-minecraft
    , nixpkgs
    , sops-nix
    , unstable
  , ... }@inputs:
    let
      overlay-unstable = final: prev: {
        unstable = unstable.legacyPackages.${prev.system};
      };
    in
    {
      nixosConfigurations = {
        
        #aragon = nixpkgs.lib.nixosSystem {
        #  system = "x83_64-linux";
        #  specialArgs = {
        #    inherit inputs;
        #  };
        #  modules = [
        #    # Overlays-module makes "pkgs.unstable" available in configuration.nix
        #    ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
        #    ./machines/aragon/configuration.nix
        #    sops-nix.nixosModules.sops
        #    home-manager.nixosModules.home-manager {
        #      home-manager.useGlobalPkgs = true;
        #      home-manager.useUserPackages = true;
        #      home-manager.users."gunalx" = import ./home/home.nix;
        #    }
        #  ];
        #};

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




















































































































