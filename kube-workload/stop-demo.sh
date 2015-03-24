#! /bin/bash

# This script stops the Guestbook demo setup
# In the first step, the instance count for all controllers is updated to zero.
# In the second step controllers and services are deleted.

chdir stop
kubectl update -f skydns-controller.yaml
kubectl update -f frontend-controller.json
kubectl update -f redis-slave-controller.json
kubectl update -f redis-master-controller.json
kubectl delete -f skydns-controller.yaml
kubectl delete -f frontend-controller.json
kubectl delete -f redis-slave-controller.json
kubectl delete -f redis-master-controller.json
kubectl delete -f skydns-service.yaml
kubectl delete -f frontend-service.json
kubectl delete -f redis-master-service.json
kubectl delete -f redis-slave-service.json
