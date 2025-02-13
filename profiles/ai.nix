{ config, pkgs, lib, ... }:
{
    imports =
        [ 
          ./base.nix
          ../services/podman.nix
          ../services/ollama.nix
          ../services/ollamaWebui.nix
          # ../services/whisper.nix
        ];
    
    environment.systemPackages = with pkgs.unstable; [
	    ollama
      openai-whisper
      openai-whisper-cpp
      wyoming-faster-whisper
      wyoming-piper
      subtitlr
      piper-tts
      bark
      
      # #piper-train #broken
      python3
      python3Packages.openai-whisper
      python3Packages.faster-whisper
      python3Packages.scipy
      # python3Packages.numba-scipy
      # python3Packages.scikit-image
      # python3Packages.traittypes
      # python3Packages.statsmodels
      # python3Packages.scikits-odes
      python3Packages.sympy
      python3Packages.numpy
      python3Packages.pandas
      python3Packages.matplotlib
      # python3Packages.tensorflow
      # python3Packages.tensorboard
      # python3Packages.keras
      python3Packages.transformers
      python3Packages.torch
      # python3Packages.torchvision-bin
      # python3Packages.torchsde
      # python3Packages.torchaudio-bin
      # python3Packages.torchWithRocm
      # python3Packages.torchWithCuda
      # python3Packages.scikit-learn-extra
      python3Packages.langchain
      python3Packages.langchain-community
      python3Packages.langchain-core
      python3Packages.langchain-chroma
      python3Packages.langchain-text-splitters
    ];



}
