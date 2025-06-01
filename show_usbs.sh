#!/bin/bash

# Show USB devices by IOMMU group
for devPath in /sys/kernel/iommu_groups/*/devices/*; do
  iommuGroup=$(basename "$(dirname "$devPath")")
  pciAddr=$(basename "$devPath")
  usbBus=$(lsusb -t | grep "$pciAddr" | awk '{print $3}' | sed 's/://')

  # Skip non-USB controllers
  if ! lspci -s "$pciAddr" | grep -qi usb; then
    continue
  fi

  echo "Bus $usbBus --> $pciAddr (IOMMU group $iommuGroup)"

  # List all USB devices on that bus
  for usbDev in /sys/bus/usb/devices/*; do
    [[ -f "$usbDev/busnum" ]] || continue
    busNum=$(cat "$usbDev/busnum")
    devNum=$(cat "$usbDev/devnum")
    idVendor=$(cat "$usbDev/idVendor")
    idProduct=$(cat "$usbDev/idProduct")
    product=$(lsusb | grep "$idVendor:$idProduct" | cut -d' ' -f7-)

    printf "Bus %03d Device %03d: ID %s:%s %s\n" "$busNum" "$devNum" "$idVendor" "$idProduct" "$product"
  done | grep "Bus $usbBus"

  echo
done
