# NixOS Configuration Repository

**Work-in-progress setup**

## Repository Structure
This repository contains my NixOS configuration files organized into several directories:
* `home/`: Home manager
* `machines/`: Machine-specific configurations
* `packages/`: Custom package definitions and configs.
* `profiles/`: System profiles (desktop, development, etc.)
* `services/`: Service configurations (nginx, mysql, etc.)
* `secrets/`: Encrypted secrets

## Quick Start
### Build Configuration
```bash
nix --extra-experimental-features "nix-command flakes" build ".#nixosConfigurations.galadriel.config.system.build.toplevel"
```

### Rebuild and Switch
The primary rebuild command is:
```bash
sudo nixos-rebuild switch --flake .# --no-write-lock-file -L --impure
```
This command:
* Uses the current flake
* Disables lock file writing
* Enables debug logging (-L)
* Allows impure derivations

#### Alternative Rebuild Methods
1. **Remote Flake**:
```bash
sudo nixos-rebuild switch \
  --update-input nixpkgs \
  --update-input unstable \
  --no-write-lock-file \
  --refresh \
  --flake git+https://github.com/adrlau/nix-dotfiles.git \
  --upgrade
```

2. **Standard Local Rebuild**:
```bash
sudo nixos-rebuild switch --flake .#
```

## Dependency Inspection
Check package relationships using:
```bash
nix why-depends /run/current-system /nix/store/...
nix why-depends .#nixosConfigurations.galadriel nixpkgs#python312Packages.botorch
nix why-depends .#nixosConfigurations.eowyn.config.system.build.toplevel pkgs.python3.12-libarcus-4.12.0 --impure
```


show flake attrs
```nix flake show .#```

## Troubleshooting
### Fix Broken Store
After aborted rebuilds:
```bash
nix-store --query --referrers-closure \
    $(find /nix/store -maxdepth 1 -type f -name '*.drv' -size 0) |
    xargs sudo nix-store --delete --ignore-liveness
sudo nix store gc
sudo nix store verify --repair --all
```

### Viewing Logs
Check home-manager logs:
```bash
journalctl -eu home-manager-gunalx
```

## Maintenance
Clean old generations:
```bash
sudo nix-collect-garbage --delete-older-than 4d
```

## Notes
* This configuration is constantly evolving
* Refer to specific machine configurations in `machines/` for details
* Service configurations are located in `services/`
* Custom packages are defined in `packages/` 
