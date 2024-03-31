# nix-dotfiles
My nix dotfiles. Will not guarrante it to work as it is always a work in progress. 

nix --extra-experimental-features "nix-command flakes" build ".#nixosConfigurations.galadriel.config.system.build.toplevel"

nixos-rebuild switch --update-input nixpkgs --update-input unstable --no-write-lock-file --refresh --flake git+https://github.com/adrlau/nix-dotfiles.git --upgrade
