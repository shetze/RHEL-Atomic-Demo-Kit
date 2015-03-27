#! /bin/bash
# This script creates three virtual machines, RHEL-Atomic{01,02,03} completely configured to join a Kubernetes cluster as minions.
# All configuration is done through cloud-init. The configuration data is provided by NoCloud datasource.
# (see http://cloudinit.readthedocs.org/en/latest/topics/datasources.html#no-cloud for further information)
# Go through all settings in the meta-data and user-data files to make sure the settings match your environment.
# At least you should change the password and put your SSH key into the user-data.

# Warning!
# The static network configuration provided by this example causes NetworkManager to send messages to /usr/bin/dbus-daemon which appearently is denied by SELinux
# This leads to a very long startup time for the VMs
# You need to wait until ssh login becomes available.
#
# Then you need to reboot the VMs to get all network configuration work as designed!!
# If you do not reboot, flannel will not work and you will have both the static and the dhcp address on your interfaces.


for instance in 1 2 3; do
  cp meta-data-at0$instance meta-data
  genisoimage -output /var/lib/libvirt/images/at0$instance-init.iso -volid cidata -joliet -rock user-data meta-data
  qemu-img create -f qcow2 -b /VirtualMachines/rhel-atomic-cloud-7.1-0.x86_64.qcow2 /VirtualMachines/RHEL-Atomic0$instance.qc2
  virt-install --import --name RHEL-Atomic0$instance --ram 1024 --vcpus 1 --disk path=/VirtualMachines/RHEL-Atomic0$instance.qc2 --disk path=/var/lib/libvirt/images/at0$insance-init.iso,device=cdrom --network bridge=br0 --force
done
