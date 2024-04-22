{ config, pkgs, lib, ... }:
{
    imports =
        [ 
          ./base.nix
          ../services/podman.nix
          ../services/ollama.nix
          ../services/whisper.nix
        ];
    
    environment.systemPackages = with pkgs.unstable; [
	    # ollama
      # openai-whisper
      # openai-whisper-cpp
      # wyoming-faster-whisper
      # subtitlr
      # piper-tts
      # #piper-train #broken
      # wyoming-piper
      # python3
      # python3Packages.torchWithCuda
      # python3Packages.openai-whisper
      # python3Packages.faster-whisper
      # python3Packages.scipy
      # python3Packages.numba-scipy
      # python3Packages.scikit-image
      # python3Packages.traittypes
      # python3Packages.statsmodels
      # python3Packages.scikits-odes
      # python3Packages.sympy
      # python3Packages.numpy
      # python3Packages.pandas
    	# python3Packages.matplotlib
      # python3Packages.tensorflow
      # python3Packages.tensorboard
      # python3Packages.keras
      # python3Packages.transformers
      # python3Packages.torch
      # python3Packages.torchvision-bin
      # python3Packages.torchsde
      # python3Packages.torchaudio-bin
      # python3Packages.torchWithRocm
      # python3Packages.torchWithCuda
      # python3Packages.scikit-learn-extra
    ];



}
