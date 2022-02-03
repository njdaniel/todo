

db-up:
	docker run --name postgres -e POSTGRES_PASSWORD=postgres -d postgres
	#docker run --name postgres -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 postgres

db-create:
	buffalo db create --all
	buffalo db migrate up

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
