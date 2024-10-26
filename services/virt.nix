{ config, pkgs, lib, ... }:
{

  # Enable libvirt and QEMU
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;

  boot.kernelModules = [ "kvm-intel" "vfio_pci" "drm" "drm_kms_helper"];
  
  # Add the relevant packages for virtualization, including secure boot and TPM support
  virtualisation.libvirtd.qemu = {
    runAsRoot = true;
    swtpm.enable = true;
    ovmf = {
      enable = true;
      packages = [(pkgs.OVMF.override {
        secureBoot = true;
        tpmSupport = true;
      }).fd];
    };
  };

  # Add your user to the libvirt group to allow managing VMs without sudo
  users.users.gunalx.extraGroups = [ "libvirtd" ];

  # Enable nested virtualization if needed
  boot.extraModprobeConfig = "options kvm_intel nested=1";

  # (Optional) Enable the virt-manager graphical tool for managing VMs
  programs.virt-manager.enable = true;

}
