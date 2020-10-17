docker build -t andyfeetenby/multi-client:latest -t andyfeetenby/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t andyfeetenby/multi-api:latest -t andyfeetenby/multi-api:$SHA -f ./api/Dockerfile ./api
docker build -t andyfeetenby/multi-worker:latest -t andyfeetenby/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push andyfeetenby/multi-client:$SHA
docker push andyfeetenby/multi-client:latest
docker push andyfeetenby/multi-api:$SHA
docker push andyfeetenby/multi-api:latest
docker push andyfeetenby/multi-worker:$SHA
docker push andyfeetenby/multi-worker:latest

kubectl apply -f k8s

kubectl set image deployments/api-deployment api=andyfeetenby/multi-api:$SHA
kubectl set image deployments/worker-deployment worker=andyfeetenby/multi-worker:$SHA
kubectl set image deployments/client-deployment client=andyfeetenby/multi-client:$SHA
