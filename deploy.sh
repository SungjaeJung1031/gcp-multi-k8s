docker build -t jsungjei/multi-client:latest -t jsungjei/multi-client:$SHA -f ./client/Dockerfile ./client
docker buidl -t jsungjei/multi-server:latest -t jsungjei/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jsungjei/multi-worker:latest -t jsungjei/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jsungjei/multi-client:latest
docker push jsungjei/multi-server:latest
docker push jsungjei/multi-worker:latest

docker push jsungjei/multi-client:$SHA
docker push jsungjei/multi-server:$SHA
docker push jsungjei/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=jsungjei/multi-client:$SHA
kubectl set image deployments/server-deployment server=jsungjei/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jsungjei/multi-worker:$SHA
