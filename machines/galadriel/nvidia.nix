{ config, lib, pkgs, ... }:
{
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = true;
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "cuda_cudart"
  ];
  
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];
  boot.initrd.kernelModules = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      #powerManagement.enable = true;
      # Fine-grained power management. Turns off GPU when not in use. Experimental and only works on modern Nvidia GPUs (Turing or newer).
      #powerManagement.finegrained = true;

      # Use the NVidia open source kernel module (not to be confused with the independent third-party "nouveau" open source driver).
      # Currently alpha-quality/buggy, so false is currently the recommended setting.
      open = false; #need proprietary for cuda.

      # Enable the Nvidia settings menu, accessible via `nvidia-settings`.
      #nvidiaSettings = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    # Enable the CUDA toolkit
    #install packages 
     environment.systemPackages = with pkgs; [
      cudaPackages.cudatoolkit
      cudaPackages.cudnn
      nvtopPackages.nvidia
      gcc
      cudaPackages.nccl
      cmake
      #llama-cpp
      #python3Packages.pip
      #cudaPackages.cuda_cudart
      #xgboostWithCuda
      #libxcrypt-legacy
      #cudaPackages.setupCudaHook
      #cudaPackages.markForCudatoolkitRootHook
      #cudaPackages.cuda_cudart.static
      pkgs.cudaPackages.libcublas
      #cudaPackages.tensorrt_8_6_0 #needs to be added manually, to the store and is a pain because of the license agreement and garbage collection
      
    ];


}
