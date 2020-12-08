docker build -t tomasciudad/multi-client:latest -t tomasciudad/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tomasciudad/multi-server:latest -t tomasciudad/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tomasciudad/multi-worker:latest -t tomasciudad/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push tomasciudad/multi-client:latest
docker push tomasciudad/multi-server:latest
docker push tomasciudad/multi-worker:latest

docker push tomasciudad/multi-client:$SHA
docker push tomasciudad/multi-server:$SHA
docker push tomasciudad/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tomasciudad/multi-server:$SHA
kubectl set image deployments/client-deployment client=tomasciudad/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tomasciudad/multi-worker:$SHA
