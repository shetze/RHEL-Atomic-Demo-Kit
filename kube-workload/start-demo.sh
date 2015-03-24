echo "Starting Guestbook Demo"
echo
echo "Check and make sure your Kubernetes cluster is working and all minions have status 'Ready'"
echo "If not, hit CTRL-C to stop within the next three seconds."
echo
kubectl get minions
sleep 3
cd start
kubectl create -f skydns-svc.yaml
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
kubectl create -f skydns-rc.yaml
sleep 3
kubectl get services
kubectl create -f redis-master-controller.json
sleep 3
kubectl get rc
kubectl get pods
sleep 3
kubectl get pods
sleep 3
kubectl get pods
sleep 3
kubectl get pods
kubectl create -f redis-master-service.json
sleep 3
kubectl get services
kubectl create -f redis-slave-controller.json
sleep 3
kubectl get rc
kubectl get pods
sleep 3
kubectl get pods
sleep 3
kubectl get pods
sleep 3
kubectl get pods
kubectl create -f redis-slave-service.json
sleep 3
kubectl get services
kubectl create -f frontend-controller.json
sleep 3
kubectl get rc
kubectl get pods
sleep 3
kubectl get pods
sleep 3
kubectl get pods
sleep 3
kubectl get pods
kubectl create -f frontend-service.json
sleep 3
kubectl get services
