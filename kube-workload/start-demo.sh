echo "Starting Guestbook Demo"
echo
echo "Check and make sure your Kubernetes cluster is working and all minions have status 'Ready'"
echo "If not, hit CTRL-C to stop within the next three seconds."
echo
kubectl get minions
sleep 3
kubectl create -f start/skydns-service.yaml
sleep 3
kubectl get rc
kubectl get pods
sleep 3
kubectl get pods
sleep 3
kubectl get pods
sleep 3
kubectl get pods
sleep 3
kubectl get pods
kubectl create -f start/skydns-controller.yaml
sleep 3
kubectl get services
kubectl create -f start/redis-master-controller.json
sleep 3
kubectl get rc
kubectl get pods
sleep 3
kubectl get pods
sleep 3
kubectl get pods
sleep 3
kubectl get pods
kubectl create -f start/redis-master-service.json
sleep 3
kubectl get services
kubectl create -f start/redis-slave-controller.json
sleep 3
kubectl get rc
kubectl get pods
sleep 3
kubectl get pods
sleep 3
kubectl get pods
sleep 3
kubectl get pods
kubectl create -f start/redis-slave-service.json
sleep 3
kubectl get services
kubectl create -f start/frontend-controller.json
sleep 3
kubectl get rc
kubectl get pods
sleep 3
kubectl get pods
sleep 3
kubectl get pods
sleep 3
kubectl get pods
kubectl create -f start/frontend-service.json
sleep 3
kubectl get services
