certs:
	cd cert && sh create.sh

clean:
	cd cert && rm -rf *.crt *.key *.csr
	docker rm node-protected || true
	docker rmi snooze/node-protected || true
	docker rm nginx-protected || true
	docker rmi snooze/nginx-protected || true
	docker-compose stop || true
	docker-compose rm || true
	docker rmi certprotected_nginx || true
	docker rmi certprotected_node || true

node:
	cd node-protected && docker build -t snooze/node-protected .

node-run: node
	docker run --name node-protected -p 8080:8080 -d snooze/node-protected

nginx:
	cd nginx-protected && docker build -t snooze/nginx-protected .

nginx-run:
  docker run --name nginx-protected -p 80:1337 -d snooze/nginx-protected

compose:
	mkdir -p nginx-protected/certs
	cp cert/server.* nginx-protected/certs/
	cp cert/ca.crt nginx-protected/certs/
	docker-compose up -d
	rm -rf nginx-protected/certs

all: certs compose
