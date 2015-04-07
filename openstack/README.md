#OpenStack Configuration
RHEL Atomic is a perfect fit for OpenStack. As we have seen RHEL Atomic can be configured automatically using cloud-init
which is supported by OpenStack. Below are some steps to configure RHEL Atomic (minions) in OpenStack.

1. Download RHEL Atomic Cloud Image (QCOW2)
 - https://access.redhat.com/downloads/content/271/ver=/rhel---7/7.1.0/x86_64/product-downloads
2. Add RHEL Atomic Cloud Image to Glance in OpenStack
 - images->create image
3. Create security group atomic and add required rules
 - neutron security-group-create atomic --description "RHEL Atomic security group"
 - neutron security-group-rule-create atomic --protocol tcp --port-range-min 10250
 --port-range-max 10250 --direction ingress --remote-ip-prefix 0.0.0.0/0
 - neutron security-group-rule-create atomic --protocol tcp --port-range-min 4001
 --port-range-max 4001 --direction egress --remote-ip-prefix 0.0.0.0/0
 - neutron security-group-rule-create atomic --protocol tcp --port-range-min 5000
 --port-range-max 5000 --direction egress --remote-ip-prefix 0.0.0.0/0
 - neutron security-group-rule-create --protocol icmp --direction ingress default
4. Boot RHEL Atomic instance using the user-data cloud-init metadata
 - nova boot --flavor m1.small --poll --image Atomic_7_1 --key-name atomic-key
 --security-groups prod-base,atomic --user_data user-data.txt --nic net-id=e3f370ab-b6ac-4788-a739-7f8de8631518 Atomic1
5. Associate floating IP
 - nova floating-ip-associate Atomic1 192.168.123.101

Check instance log and wait until Docker service is started. Once docker is started reboot the instance, the kubernetes
services are enabled now but a full restart is needed to initialize the services correctly.

On kubernetes master you can run 'kubectl get minions' and once they are ready you are done and can start deploying
pods on RHEL Atomic on OpenStack.

[root@kubernetes ~]# kubectl get minions

NAME                LABELS              STATUS

atomic01.lab.com    <none>              Ready

