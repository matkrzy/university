env ?= ./university-api/.env

ifneq ("$(wildcard $(env))","")
all:
	include $(env)
	export $(shell sed 's/=.*//' $(env))
else
all:
	@make copy-env
endif


copy-env:
	@echo Copy env file for spa and api
	@cp ./university-api/.env.prod.dist ./university-api/.env
	@cp ./university-api/.env.prod.dist ./load-fixtures/.env
	@cp ./university-spa/.env.prod.dist ./university-spa/.env

build:
ifeq ("$(wildcard $(env))","")
up-repos:
	@make update-repos
endif
	@make copy-env
	@echo Build docker image
	docker-compose build

run:
	docker-compose run

start:
	@echo App is starting...
	docker-compose up -d

stop:
	docker-compose stop

down:
	docker-compose down

remove:
	docker-compose rm -s

load-fixtures:
	@echo Loading fixtures..
	@docker-compose up mongo-seed

update-repos:
	git submodule foreach git fetch -a
	git submodule foreach git reset --hard origin/develop

export-database:
	@mkdir ./dump
	docker exec mongo mongo --quiet $(TYPEORM_DATABASE) --eval 'printjson( db.process.find({},{"_id":0, "id": 1, "label":1,"nodes":1,"connections":1}).toArray() )' > dump/process.json
	docker exec mongo mongo --quiet $(TYPEORM_DATABASE) --eval 'printjson( db.product.find({},{"_id":0,"id":1,"label":1, "amount":1, "processId": 1}).toArray() )' > dump/product.json
