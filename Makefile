.PHONY: up down db-shell redis-shell

# Start the infrastructure
up:
	docker compose up -d

# Stop the infrastructure
down:
	docker compose down

# Access the PostgreSQL terminal
db-shell:
	docker exec -it trailguard-db psql -U trailguard_user -d trailguard

# Access the Redis terminal
redis-shell:
	docker exec -it trailguard-redis redis-cli

# Run database migrations
migrate-up:
	migrate -path internal/db/migrations -database "postgresql://trailguard_user:secretpassword@localhost:5432/trailguard?sslmode=disable" -verbose up

# Rollback database migrations
migrate-down:
	migrate -path internal/db/migrations -database "postgresql://trailguard_user:secretpassword@localhost:5432/trailguard?sslmode=disable" -verbose down