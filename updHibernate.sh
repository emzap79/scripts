#!/bin/bash

echo "#!/bin/sh
# File: "/etc/pm/sleep.d/20_custom-ehci_hcd".
case "${1}" in
    hibernate|suspend)
        # Unbind ehci_hcd for first device 0000:00:1a.0:
        echo -n "0000:00:1a.0" | tee /sys/bus/pci/drivers/ehci_hcd/unbind
        # Unbind ehci_hcd for second device 0000:00:1d.0:
        echo -n "0000:00:1d.0" | tee /sys/bus/pci/drivers/ehci_hcd/unbind
        ;;
    resume|thaw)
        # Bind ehci_hcd for first device 0000:00:1a.0:
        echo -n "0000:00:1a.0" | tee /sys/bus/pci/drivers/ehci_hcd/bind
        # Bind ehci_hcd for second device 0000:00:1d.0:
        echo -n "0000:00:1d.0" | tee /sys/bus/pci/drivers/ehci_hcd/bind
        ;;
esac" | sudo tee /etc/pm/sleep.d/20_custom-ehci_hcd
sudo chmod 755 /etc/pm/sleep.d/20_custom-ehci_hcd
exit 0
