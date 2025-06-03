# nix-dotfiles
My nix dotfiles. Will not guarrante it to work as it is always a work in progress. 

nix --extra-experimental-features "nix-command flakes" build ".#nixosConfigurations.galadriel.config.system.build.toplevel"

nixos-rebuild switch --update-input nixpkgs --update-input unstable --no-write-lock-file --refresh --flake git+https://github.com/adrlau/nix-dotfiles.git --upgrade




show flake attrs
```nix flake show .#```


why depends: 
```nix why-depends /run/current-system /nix/store/...```
```nix why-depends .#```
```nix why-depends .#nixosConfigurations.galadriel nixpkgs#python312Packages.botorch```
```nix why-depends .\#nixosConfigurations.eowyn.config.system.build.toplevel pkgs.python3.12-libarcus-4.12.0 --impure```


Fix after broken store after aborted rebuild.
https://github.com/NixOS/nix/issues/11148#issuecomment-2438680917
```
nix-store --query --referrers-closure \
    $(find /nix/store -maxdepth 1 -type f -name '*.drv' -size 0) |
    xargs sudo nix-store --delete --ignore-liveness
sudo nix store gc
sudo nix store verify --repair --all
```

