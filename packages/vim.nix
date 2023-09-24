{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    configure = {
      customRC = ''
        " your custom vimrc
        set nocompatible
        set backspace=indent,eol,start
        " Turn on syntax highlighting by default
        syntax on
        " ...
      '';
      packages.myplugins = with pkgs.vimPlugins; {
        start = [ vim-nix vim-lastplace vim-yaml ];
        opt = [];
      };
    };
  };
}
