docker build -t epoepvad/multi-client:latest -t epopevad/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t epopevad/multi-server:latest -t epopevad/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t epopevad/multi-worker:latest -t epopevad/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push epopevad/mutli-client:latest
docker push epopevad/multi-server:latest
docker push epopevad/multi-worker:latest
docker push epopevad/mutli-client:$SHA
docker push epopevad/multi-server:$SHA
docker push epopevad/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=epopevad/multi-server:$SHA
kubectl set image deployments/client-deployment server=epopevad/multi-client:$SHA
kubectl set image deployments/worker-deployment server=epopevad/multi-worker:$SHA