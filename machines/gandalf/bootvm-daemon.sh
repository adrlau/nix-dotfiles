qemu-system-x86_64 \
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
  -daemonize \

#-net none
# -device hostdev,/sys/bus/pci/devices/0000:04:00.0\
#  -device hostdev,/sys/bus/pci/devices/0000:05:00.0\
#  -device hostdev,/sys/bus/pci/devices/0000:06:00.0\
#  -device hostdev,/sys/bus/pci/devices/0000:07:00.0\
#  -device hostdev,/sys/bus/pci/devices/0000:08:00.0\
#  -device hostdev,/sys/bus/pci/devices/0000:0b:00.0\
#  -device hostdev,/sys/bus/pci/devices/0000:0b:00.1\
#  -device hostdev,/sys/bus/pci/devices/0000:0c:00.0\
#  -device hostdev,/sys/bus/pci/devices/0000:0c:00.1\ #
