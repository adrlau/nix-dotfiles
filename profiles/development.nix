{ config, pkgs, lib, ... }:
{
imports =
    [
      ./base.nix 
      #./ai.nix 
      
    ];

  environment.systemPackages = with pkgs; [


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


     ];

}
