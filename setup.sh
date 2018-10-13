#!/bin/bash

# replace config
sed -i "s|#DB_HOST#|$DB_HOST|" wordpress/deployment.yml
sed -i "s|#DB_USER#|$DB_USER|" wordpress/deployment.yml
sed -i "s|#DB_PASSWORD#|$DB_PASSWORD|" wordpress/deployment.yml

kubectl apply -f wordpress

while true; do
  kubectl get services wordpress | grep -q '<pending>' || break
  sleep 1
done;
IP=$(kubectl get services wordpress | tail -n 1 | awk '{ print $4 }')
echo "Ip Server: http://$IP"

