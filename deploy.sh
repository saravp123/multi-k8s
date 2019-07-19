docker build -t saravp123/multi-client:latest -t saravp123/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t saravp123/multi-server:latest -t saravp123/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t saravp123/multi-worker:latest -t saravp123/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push saravp123/multi-client:latest
docker push saravp123/multi-server:latest
docker push saravp123/multi-worker:latest

docker push saravp123/multi-client:$SHA
docker push saravp123/multi-server:$SHA
docker push saravp123/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=saravp123/multi-server:$SHA
kubectl set image deployments/client-deployment client=saravp123/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=saravp123/multi-worker:$SHA