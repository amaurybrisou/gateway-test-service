ENV=.env


.bin:
	mkdir -p $(shell pwd)/.bin

.PHONY: build
build: .bin
	go build -o .bin/backend main.go

.PHONY: build-docker
build-docker:
	docker build --platform linux/amd64 -t "docker.io/brisouamaury/gateway-test-service:latest" --push .

.PHONY: start
start: pull
	docker-compose --env-file $(ENV) -f docker-compose.yml up -d

.PHONY: stop
stop:
	docker-compose --env-file $(ENV) down

.PHONY: pull
pull:
	docker-compose --env-file $(ENV) pull

.PHONY: clean
clean:
	docker system prune -f
	docker volume prune -f

.PHONY: logs
logs:
	docker-compose --env-file $(ENV) logs -f

.PHONY: shell
shell:
	docker exec -it test-service_backend_1 /bin/bash


.PHONY: lint
lint:
	golangci-lint run ./...

.PHONY: test
test:
	@go test -count=1 -timeout 3m -v ./...