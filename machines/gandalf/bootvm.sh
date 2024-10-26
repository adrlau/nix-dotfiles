qemu-system-x86_64 \
  -m 4G \
  -cpu host \
  -smp 2 \
  -enable-kvm \
  -device vfio-pci,host=04:00.0 \
  -device vfio-pci,host=05:00.0 \
  -drive file=/vm-images/OPNsense-24.7-nano-amd64.img,format=raw \
  -vga virtio \
  -netdev user,id=net0 -device virtio-net,netdev=net0 \
  -daemonize \
  -vnc

#-nographic \
#-net none
