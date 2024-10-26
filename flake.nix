{
  description = "My System flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-colors.url = "github:misterio77/nix-colors"; 
    
    # stylix.url = "github:bluskript/stylix/6bc871ab352c9f18d1179daab9e392a4d46393af";
    # stylix.inputs.nixpkgs.follows = "nixpkgs";
    # stylix.inputs.home-manager.follows = "home-manager";

    NixVirt.url = "https://flakehub.com/f/AshleyYakeley/NixVirt/*.tar.gz";
    NixVirt.inputs.nixpkgs.follows = "nixpkgs";


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
    , nix-colors
    , matrix-synapse-next
    , ozai
    , ozai-webui
    , nix-minecraft
    , nixpkgs
    , sops-nix
    , nixos-hardware
    , NixVirt
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
              home-manager.backupFileExtension = "bac";
              home-manager.extraSpecialArgs = {inherit nix-colors inputs;};
            }
            #need to choose one. The nixos one has bootloader and display manager in addition to the home manager one.
            #inputs.stylix.nixosModules.stylix
            #inputs.stylix.homeManagerModules.stylix
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
        
      gandalf = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            NixVirt.nixosModules.default
            ./machines/gandalf/configuration.nix
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
            sops-nix.nixosModules.sops

            ({ config, pkgs, ... }: {
            # Your VM configuration here
            virtualisation.libvirt.enable = true;
            virtualisation.libvirt.connections."qemu:///system".domains = [
              {
                definition = NixVirt.lib.domain.writeXML (NixVirt.lib.domain.templates.q35 {
                  name = "gandalf-grey";
                  uuid = "a1db010b-4ad3-436a-bd99-f290f5ac8806"; # Replace with a generated UUID
                  memory = { count = 4; unit = "GiB"; };
                  vcpu = { value = 2; }; # Number of CPU cores
                  storage_vol = "/vm-images/OPNsense-24.7-nano-amd64.img"; # Path to your storage image file
                  install_vol = null; # No installation volume since we're using an existing image
                  virtio_net = true;
                  virtio_video = true;
                  virtio_drive = true;
                  devices = [
                    { hostdev = "/sys/bus/pci/devices/0000:04:00.0"; }
                    { hostdev = "/sys/bus/pci/devices/0000:05:00.0"; }
                    { hostdev = "/sys/bus/pci/devices/0000:06:00.0"; }
                    { hostdev = "/sys/bus/pci/devices/0000:07:00.0"; }
                    { hostdev = "/sys/bus/pci/devices/0000:08:00.0"; }
                    { hostdev = "/sys/bus/pci/devices/0000:0b:00.0"; }
                    { hostdev = "/sys/bus/pci/devices/0000:0b:00.1"; }
                    { hostdev = "/sys/bus/pci/devices/0000:0c:00.0"; }
                    { hostdev = "/sys/bus/pci/devices/0000:0c:00.1"; }
                  ];
                });
                active = true;
              }
            ];
          })

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
            inputs.ozai.nixosModules.ozai
            inputs.ozai-webui.nixosModules.ozai-webui
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


