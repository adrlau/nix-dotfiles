{ pkgs, lib, ... }:
{
  imports = [
    ../common/sshconfig.nix
  ];

  programs.nix-index = {
    enable = true;
  };
  
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  programs.bash = {
    enable = true;
    shellAliases  = {
        "rebuild" = "sudo nixos-rebuild switch --update-input nixpkgs --update-input unstable --no-write-lock-file --refresh --flake git+https://github.com/adrlau/nix-dotfiles.git --upgrade";
        "nixedit" = "vim /etc/nixos/nix-dotfiles/.";
        "nixdir" = "cd /etc/nixos/nix-dotfiles";


        "," = "comma ";

        "gst" = "git status";
        "gsw" = "git switch";
        "gcm" = "git commit -m ";
        "gca" = "git commit --amend";
        "gaa" = "git add -A";
        "gb" = "git branch";

        "sl" = "eza";
        "ls" = "eza";
        "lls" = "ls";
        "la" = "eza -la";
        "tree" = "eza -T";
        "neofetch" = "fastfetch";
    };
    historyControl = ["ignoredups" "ignorespace" "erasedups"];
    historyIgnore = [ "ls" "cd" "exit" "cd .." ".." "la"];
  };

  home.packages = with pkgs; [
    bottom
    htop
    fastfetch
    eza
    ripgrep
    foot.terminfo
    comma
  ];

  programs.git = {
    enable = true;

    extraConfig = {
      pull.rebase = true;
      push.autoSetupRemote = true;
      color.ui = "auto";
      init.defaultBranch = "main";
      lfs.enable = true;
      user = {
        name = "Adrian G L";
        email = "adrian@lauterer.it";
      };
    };
    ignores = [
      "*~"
      "*.swp"
      ".DS_Store"
      ".vscode"
      "*__PYCACHE__*"
      "*__pycache__*"
    ];
  };

  home.stateVersion = "23.05";
}

