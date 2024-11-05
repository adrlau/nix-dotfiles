{ pkgs, ... }:
{

  users.users.qemu = {
    isSystemUser = true;
    description = "QEMU User";
    home = "/var/lib/qemu";
    createHome = true;
    group = "qemu";
    extraGroups = [ "vfio" ];  # Add qemu to vfio group
  };
  users.groups.qemu = {};

services.udev.extraRules = ''
  # Set proper permissions for VFIO devices
  SUBSYSTEM=="vfio", GROUP="vfio", MODE="0660"
'';


  environment.systemPackages = with pkgs; [
    qemu_kvm
  ];

  systemd.services.qemu-vm = {
    description = "QEMU VM Service";
    #wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      #can add ,rombar=0 to vfio devices, but it does at least run now.
      ExecStart = ''
        ${pkgs.qemu_kvm}/bin/qemu-system-x86_64 \
        -m 4G \
        -cpu host \
        -smp 2 \
        -enable-kvm \
        -device vfio-pci,host=04:00.0 \
        -device vfio-pci,host=05:00.0 \
        -device vfio-pci,host=06:00.0 \
        -device vfio-pci,host=07:00.0 \
        -device vfio-pci,host=08:00.0 \
        -device vfio-pci,host=0b:00.0 \
        -device vfio-pci,host=0b:00.1 \
        -device vfio-pci,host=0c:00.0 \
        -device vfio-pci,host=0c:00.1 \
        -drive file=/vm-images/OPNsense-24.7-nano-amd64.img,format=raw \
        -vga virtio \
        -netdev user,id=net0 -device virtio-net,netdev=net0 \
        -display none \
        #-daemonize
      '';
      Restart = "on-failure";
      User = "root";  # Run as the qemu user
    };
  };
}

