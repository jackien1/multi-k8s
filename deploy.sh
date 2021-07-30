docker build -t jackieni/multi-client:latest -t jackieni/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jackieni/multi-server:latest -t jackieni/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jackieni/multi-worker:latest -t jackieni/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jackieni/multi-client:latest
docker push jackieni/multi-server:latest
docker push jackieni/multi-worker:latest

docker push jackieni/multi-client:$SHA
docker push jackieni/multi-server:$SHA
docker push jackieni/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jackieni/multi-server:$SHA
kubectl set image deployments/client-deployment client=jackieni/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jackieni/multi-worker:$SHA

