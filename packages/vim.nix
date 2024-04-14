{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    withPython3 = true;
    withNodeJs = true;

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
        start = [ vim-nix vim-lastplace vim-yaml coc-rust-analyzer neovim-fuzzy LanguageClient-neovim copilot-vim chadtree];
        opt = [];
      };
    };
  };
}
