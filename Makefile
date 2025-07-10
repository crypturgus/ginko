.PHONY: build run shell

build:
	docker compose build

run:
	docker compose -f docker-compose.dev.yml up 2>&1 | tee -a docker_build.dev.log

shell:
	docker compose run --rm shiny bash
refresh-external:
	docker-compose run --rm ginko Rscript scripts/fetch_external.R

dev-build:
	rm docker_build.dev.log
	docker compose -f docker-compose.dev.yml build --no-cache 2>&1 | tee docker_build.dev.log && \
	docker compose -f docker-compose.dev.yml up 2>&1 | tee -a docker_build.dev.log

dev-bash:
	docker compose -f docker-compose.dev.yml exec ginko-dev bash
res:
		docker compose -f docker-compose.dev.yml restart