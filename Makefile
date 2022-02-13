
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

db-up:
	docker run --name postgres -e POSTGRES_PASSWORD=postgres -d postgres
	#docker run --name postgres -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 postgres

db-create:
	buffalo db create --all

seed:
	@echo "seeding..."
	psql -h localhost -U postgres -p 5432 -d todo_development -c "\copy tasks(id, description, done, created_at, updated_at) FROM ./data.csv DELIMITER '|' CSV HEADER;"


run:
	buffalo dev

test:
	@echo "Testing endpoints"
	./scripts/endpoint-test.sh

clean:
	go clean
	docker system prune -f
