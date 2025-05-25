{ config, pkgs, lib, ... }:
{
imports =
    [
      ./base.nix 
      #./ai.nix 
      
    ];

  environment.systemPackages = with pkgs; [
    zed-editor-fhs
    aider-chat

    python3Full
    uv
    python3Packages.pip
    python3Packages.uv
    poetry
    


    texliveFull
    pandoc
    pandoc-plantuml-filter
    plantuml
    haskellPackages.pandoc-plot
    pandoc-imagine
    pandoc-katex
    haskellPackages.pandoc-cli
    pandoc-include

    markdownlint-cli
    libsForQt5.kate
    
    poetry
    gcc
    cargo
    rustup


    cmake
    gnumake
    mpi
    bc
    gnuplot
    ffmpeg

    ripes

     ];

}
