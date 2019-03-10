docker build -t mrfredland/multi-client:latest -t mrfredland/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mrfredland/multi-server:latest -t mrfredland/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mrfredland/multi-worker:latest -t mrfredland/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push mrfredland/multi-client:latest
docker push mrfredland/multi-server:latest
docker push mrfredland/multi-worker:latest
docker push mrfredland/multi-client:$SHA
docker push mrfredland/multi-server:$SHA
docker push mrfredland/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mrfredland/multi-server:$SHA
kubectl set image deployments/client-deployment client=mrfredland/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mrfredland/multi-worker:$SHA
