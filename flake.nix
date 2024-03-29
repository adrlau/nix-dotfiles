{
  description = "stolen from PVV System flake, not currently implemented";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11-small";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable-small";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    matrix-next.url = "github:dali99/nixos-matrix-modules";
    matrix-next.inputs.nixpkgs.follows = "nixpkgs";

    grzegorz.url = "github:Programvareverkstedet/grzegorz";
    grzegorz.inputs.nixpkgs.follows = "nixpkgs-unstable";
    grzegorz-clients.url = "github:Programvareverkstedet/grzegorz-clients";
    grzegorz-clients.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, sops-nix, disko, ... }@inputs:
  let
    nixlib = nixpkgs.lib;
    systems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    forAllSystems = f: nixlib.genAttrs systems (system: f system);
    allMachines = nixlib.mapAttrsToList (name: _: name) self.nixosConfigurations;
    importantMachines = [
      "aragon"
      "galadriel"
      "elrond"
      "georg"
    ];
  in {
    nixosConfigurations = let
      nixosConfig = nixpkgs: name: config: nixpkgs.lib.nixosSystem (nixpkgs.lib.recursiveUpdate
        rec {
          system = "x86_64-linux";
          specialArgs = {
            inherit nixpkgs-unstable inputs;
            values = import ./values.nix;
          };

          modules = [
            ./hosts/${name}/configuration.nix
            sops-nix.nixosModules.sops
          ];

          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              inputs.pvv-calendar-bot.overlays.${system}.default
            ];
          };
        }
        config
      );

      stableNixosConfig = nixosConfig nixpkgs;
      unstableNixosConfig = nixosConfig nixpkgs-unstable;
    in {
      bicep = stableNixosConfig "bicep" {
        modules = [
          ./hosts/bicep/configuration.nix
          sops-nix.nixosModules.sops

          inputs.matrix-next.nixosModules.default
          inputs.pvv-calendar-bot.nixosModules.default
        ];
      };
      
      #was bekkalokk
      galadriel = stableNixosConfig "galadriel" { };
    
      ildkule = stableNixosConfig "ildkule" { };
      
      shark = stableNixosConfig "shark" { };
      
      georg = stableNixosConfig "georg" {
        modules = [
          ./hosts/georg/configuration.nix
          sops-nix.nixosModules.sops

          inputs.grzegorz.nixosModules.grzegorz-kiosk
          inputs.grzegorz-clients.nixosModules.grzegorz-webui
        ];
      };
      
      buskerud = stableNixosConfig "buskerud" {
        modules = [
          ./hosts/buskerud/configuration.nix
          sops-nix.nixosModules.sops
        ];
      };
    };

    #devShells = forAllSystems (system: {
    #  default = nixpkgs.legacyPackages.${system}.callPackage ./shell.nix { };
    #});

    packages = {
      "x86_64-linux" = let
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
      in rec {
        
        default = important-machines;
        
        important-machines = pkgs.linkFarm "important-machines"
          (nixlib.getAttrs importantMachines self.packages.x86_64-linux);
        all-machines = pkgs.linkFarm "all-machines"
          (nixlib.getAttrs allMachines self.packages.x86_64-linux);
      } // nixlib.genAttrs allMachines
        (machine: self.nixosConfigurations.${machine}.config.system.build.toplevel);
    };
  };
}
