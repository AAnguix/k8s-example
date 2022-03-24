docker build -t anguixa/multi-client:latest -t anguixa/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t anguixa/multi-server:latest -t anguixa/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t anguixa/multi-worker:latest -t anguixa/multi-worker:$SHA -f ./worker/Dockerfile ./worker


docker push anguixa/multi-client:latest
docker push anguixa/multi-server:latest
docker push anguixa/multi-worker:latest

docker push anguixa/multi-client:$SHA
docker push anguixa/multi-server:$SHA
docker push anguixa/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=anguixa/multi-server:$SHA
kubectl set image deployments/client-deployment client=anguixa/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=anguixa/multi-worker:$SHA