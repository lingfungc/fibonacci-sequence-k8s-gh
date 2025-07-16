docker build -t lingfungc/fibonacci-client:latest -t lingfungc/fibonacci-client:$SHA -f ./client/Dockerfile ./client
docker build -t lingfungc/fibonacci-server:latest -t lingfungc/fibonacci-server:$SHA -f ./server/Dockerfile ./server
docker build -t lingfungc/fibonacci-worker:latest -t lingfungc/fibonacci-worker:$SHA -f ./worker/Dockerfile ./worker


docker push lingfungc/fibonacci-client:latest
docker push lingfungc/fibonacci-server:latest
docker push lingfungc/fibonacci-worker:latest

docker push lingfungc/fibonacci-client:$SHA
docker push lingfungc/fibonacci-server:$SHA
docker push lingfungc/fibonacci-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=lingfungc/fibonacci-client:$SHA
kubectl set image deployments/server-deployment server=lingfungc/fibonacci-server:$SHA
kubectl set image deployments/worker-deployment worker=lingfungc/fibonacci-worker:$SHA
