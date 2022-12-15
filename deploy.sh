# 6. Build all our images, tag each one, push each to docker hub
docker build -t kamwil314/multi-client:latest -t kamwil314/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kamwil314/multi-server:latest -t kamwil314/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kamwil314/multi-worker:latest -t kamwil314/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push kamwil314/multi-client:latest
docker push kamwil314/multi-server:latets
docker push kamwil314/multi-worker:latest
docker push kamwil314/multi-client:$SHA
docker push kamwil314/multi-server:$SHA
docker push kamwil314/multi-worker:$SHA
# 7. Apply all configs in the 'k8s' folder
kubectl apply -f k8s
# 8. Imperatively set latest images on each deployment
kubectl set image deployments/server-deployment server=kamwil314/multi-server:$SHA
kubectl set image deployments/client-deployment client=kamwil314/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kamwil314/multi-worker:$SHA