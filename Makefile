APPLICATION_NAME = blog_api
WEB_CONTAINER_NAME = web
.DEFAULT_GOAL := help

serve: ## Run Serve
	- make up
	- make attach

up: ## Run containers
	docker-compose up -d

down: ## Stop containers
	docker-compose down

ps: ## List containers
	docker-compose ps

restart_web: ## Restart Web container
	- docker-compose restart $(WEB_CONTAINER_NAME)

guard: ## Run project guard (in running container)
	- make up
	- docker-compose exec $(WEB_CONTAINER_NAME) bundle exec guard

console: ## Run Rails console
	docker-compose run --rm $(WEB_CONTAINER_NAME) bundle exec rails c

bundle: ## Run bundle install
	docker-compose run --rm $(WEB_CONTAINER_NAME) bundle install

tests: ## Run test locally in web container (with failfast option)
	docker-compose run -e FAILFAST=true -e COVERAGE=true --rm $(WEB_CONTAINER_NAME) bundle exec rspec .

migrate: ## Run rake db migrate
	docker-compose run --rm $(WEB_CONTAINER_NAME) bundle exec rake db:migrate

attach: ## Attach running web container for binding.pry
	docker attach $(APPLICATION_NAME)_$(WEB_CONTAINER_NAME)_1

sniff: ## Run code smelling tools (rubocop only for now)
	docker-compose run --rm $(WEB_CONTAINER_NAME) bundle exec rubocop .

.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
