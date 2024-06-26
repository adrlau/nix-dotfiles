{ config, lib, pkgs, ... }:
{
  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];
  #boot with nvidia kernel module
  boot.initrd.kernelModules = [ "nvidia" ];
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;
      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      #powerManagement.enable = true;
      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      #powerManagement.finegrained = true;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of 
      # supported GPUs is at: 
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
      # Only available from driver 515.43.04+
      # Currently alpha-quality/buggy, so false is currently the recommended setting.
      open = false;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
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
      llama-cpp
      python3Packages.pip
      #cudaPackages.cuda_cudart
      #xgboostWithCuda
      #libxcrypt-legacy
      #cudaPackages.setupCudaHook
      #cudaPackages.markForCudatoolkitRootHook
      #cudaPackages.cuda_cudart.static
      #pkgs.cudaPackages.libcublas
      #cudaPackages.tensorrt_8_6_0 #needs to be added manually, to the store and is a pain because of the license agreement and garbage collection
      
    ];


  }
