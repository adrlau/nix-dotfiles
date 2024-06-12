{ pkgs, lib, ... }:
{
  imports = [
  ];

  programs.bash = {
    shellAliases  = {
        "rebuild" = "sudo nixos-rebuild switch --update-input nixpkgs --update-input unstable --no-write-lock-file --refresh --flake git+https://github.com/adrlau/nix-dotfiles.git --upgrade";
        "nixedit" = "vim /etc/nixos/nix-dotfiles/.";
        "gst" = "git status";
        "gsw" = "git switch";
        "gcm" = "git commit -m ";
        "gca" = "git commit --amend";
        "gaa" = "git add -A";
        "gb" = "git branch";
        "sl" = "ls";
        "la" = "la -la";
        "neofetch" = "fastfetch";
    };


  };

  home.packages = with pkgs; [
    bottom
    htop
    fastfetch
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

