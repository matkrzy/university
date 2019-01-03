copy-env:
	@echo Copy env file for spa and api
	@cp ./university-api/.env.prod.dist ./university-api/.env
	@cp ./university-api/.env.prod.dist ./load-fixtures/.env
	@cp ./university-spa/.env.prod.dist ./university-spa/.env

build:
	@make update-repos
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
	@docker-compose run mongo-seed

update-repos:
	git submodule foreach git fetch -a
	git submodule foreach git reset --hard origin/develop

	


