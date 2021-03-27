docker build -t kommera1979/multi-client:latest -t kommera1979/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kommera1979/multi-server:latest -t kommera1979/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kommera1979/multi-worker:latest -t kommera1979/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push kommera1979/multi-client:latest
docker push kommera1979/multi-server:latest
docker push kommera1979/multi-worker:latest

docker push kommera1979/multi-client:$SHA
docker push kommera1979/multi-server:$SHA
docker push kommera1979/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kommera1979/multi-server:$SHA
kubectl set image deployments/client-deployment client=kommera1979/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kommera1979/multi-server:$SHA
