env ?= .env
include $(env)
export $(shell sed 's/=.*//' $(env))

load-fixtures:
	@make unload
	@make load

load:
	@yarn load -- mongodb://mongo:27017/$(TYPEORM_DATABASE) --path $(FIXTURES_PATH)

unload:
	@yarn unload -- mongodb://mongo:27017/$(TYPEORM_DATABASE) --path $(FIXTURES_PATH)
