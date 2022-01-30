

db-up:
	docker run --name postgres -e POSTGRES_PASSWORD=postgres -d postgres

seed:
	psql -h localhost -U postgres -p 5432 -d todo_development -c "\copy tasks(id, description, done, created_at, updated_at) FROM ./data.csv DELIMITER '|' CSV HEADER;"


run:
	buffalo dev
