# RHEL-Atomic-Demo-Kit
Demo Setup for RHEL Atomic and Kubernetes Demo

This is a brief instruction how to setup and perform a RHEL Atomic Host and
Kubernetes / Docker demo.

If you need a more detailed instructions and background information, look at
the excellent lab course created by Scott Collier:
https://github.com/scollier/SATraining


To start with this Demo you need a KVM/libvirt host with at least 8GB of RAM
and 60 GB of disk space available for the VMs.  We are going to create one VM
as Kubernetes master and three RHEL Atomic Host instances as minions to join
the cluster.

To get the setup working, one reboot of all the systems is required.  So I
recommend first installing the Kubernetes master, then setting up the Atomic
Hosts.  Once als systems are configured, the cluster is restarted.

After the master is up and running again, check if "kubectl get minions" shows
the Atomic Hosts being ready.  Then continue with scheduling some workload into
that cluster.

The demo workoad is taken from the Kubernetes Guestbook example.
This application uses three example-guestbook-php-redis instances talking to
two redis-slave instances that in turn work with one redis-master backend.
To get the backend communication going an additional DNS service is provided
that consists of three different containers (etcd backend, skydns
application and kube2sky frontend bridge) combined into one single Pod.
So, if everything works as intendet we have a nice little example with lots of
fairly complex interaction...

And these are the 6 simple steps to get this up and running:

1. Follow the instructions in kube-master/HowTo-Create-A-Kubernetes-Master
2. Adjust the configuration and run the create-Minions.sh script in
   kube-minions.
3. Reboot master and minions
4. check if minions have status ready
5. go to kube-workload and start the demo
6. open http://atomic01.example.com:8000 (http://192.168.122.21:8000) in your
   browser and check if the messages you submitted appear in the body of that
   page.

What else to look at...

- you can examine the cluster:
  - "kubectl get pods"
  - "kubectl get services"
  - "kubectl get rc"
- you can change your workload by editing controller definitions and updating kubernetes
  - edit frontend-controller.json and change the number of replicas, then run "kubectl update -f frontend-controller.json"
    watch the number of example-guestbook-php-redis pods change
- you can log into the minions as cloud-user with password redhat (or whatever
  you changed that to in the user-data file)
  - on the minions you can explore the network configuration
    - each docker service uses a /24 subnet of the /16 flannel network
    - the flannel device uses the same network as docker, thereby connecting
      all /24 docker networks to one big /16 flannel overlay network
    - check out "iptables -nvL -t nat"
  - you can check messages from the services running inside a container
    with "docker logs <container-id>"
  - you can enter any container with "docker exec -i -t <container-id> sh"
    - from inside a container, you can ping any container running on another
      minion through the flannel overlay network
  - you can look what etcd is providing to flanneld with
    "curl -L http://192.168.122.10:4001/v2/keys/flannel/network/config"


Further reading

- https://github.com/GoogleCloudPlatform/kubernetes/tree/master/docs
