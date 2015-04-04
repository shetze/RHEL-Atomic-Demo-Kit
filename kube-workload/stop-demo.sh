#! /bin/bash

# This script stops the Guestbook demo setup
# In the first step, the instance count for all controllers is updated to zero.
# In the second step controllers and services are deleted.

kubectl update -f stop/skydns-controller.yaml
kubectl update -f stop/frontend-controller.json
kubectl update -f stop/redis-slave-controller.json
kubectl update -f stop/redis-master-controller.json
kubectl delete -f stop/skydns-controller.yaml
kubectl delete -f stop/frontend-controller.json
kubectl delete -f stop/redis-slave-controller.json
kubectl delete -f stop/redis-master-controller.json
kubectl delete -f stop/skydns-service.yaml
kubectl delete -f stop/frontend-service.json
kubectl delete -f stop/redis-master-service.json
kubectl delete -f stop/redis-slave-service.json
