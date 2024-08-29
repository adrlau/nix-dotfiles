{ config, pkgs, lib, ... }:
{
imports =
    [
      ./base.nix 
      
    ];

  environment.systemPackages = with pkgs; [
    libreoffice-fresh
    onlyoffice-bin

    hunspellDicts.nb_NO
    hunspellDicts.nn_NO
    hunspellDicts.de_DE
    hunspellDicts.de_AT
    hunspellDicts.en_US-large
    hunspellDicts.en_GB-large
    unoconv
    csv2odf
    hunspell

    texliveFull
    pandoc
    pandoc-plantuml-filter
    plantuml
    haskellPackages.pandoc-plot
    pandoc-imagine
    pandoc-katex
    haskellPackages.pandoc-cli
    pandoc-include

    reveal-md

    markdownlint-cli
    markdown-anki-decks

    gnucash
    wcalc
    libsForQt5.kcalc
    libsForQt5.kate
     ];

}
