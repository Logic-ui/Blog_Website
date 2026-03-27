.PHONY: help docker-up docker-dev docker-prod docker-down docker-logs docker-build docker-clean docker-db

help:
	@echo "=================================="
	@echo "   Docker Commands for Blog Website"
	@echo "=================================="
	@echo ""
	@echo "make docker-dev      - Start development with debuggers"
	@echo "make docker-up       - Start normal mode"
	@echo "make docker-prod     - Start production mode"
	@echo "make docker-down     - Stop all containers"
	@echo "make docker-logs     - View logs"
	@echo "make docker-build    - Build images"
	@echo "make docker-clean    - Remove containers and volumes"
	@echo "make docker-db       - Access PostgreSQL shell"
	@echo "make docker-backend  - Run backend tests"
	@echo ""

docker-dev:
	@echo "🚀 Starting Development Mode..."
	docker-compose -f docker-compose.dev.yml up --build

docker-up:
	@echo "🚀 Starting..."
	docker-compose up --build

docker-prod:
	@echo "🚀 Starting Production Mode..."
	docker-compose -f docker-compose.prod.yml up --build

docker-down:
	@echo "⏹️  Stopping containers..."
	docker-compose down

docker-logs:
	docker-compose logs -f

docker-logs-backend:
	docker-compose logs -f backend

docker-logs-frontend:
	docker-compose logs -f frontend

docker-build:
	@echo "🔨 Building images..."
	docker-compose build --no-cache

docker-clean:
	@echo "🧹 Cleaning up Docker..."
	docker-compose down -v
	docker system prune -a --volumes -f

docker-db:
	docker-compose exec db psql -U bloguser -d blog_db

docker-backend-shell:
	docker-compose exec backend bash

docker-frontend-shell:
	docker-compose exec frontend sh

docker-pip-install:
	docker-compose exec backend pip install $(PKG)

docker-npm-install:
	docker-compose exec frontend npm install $(PKG)

docker-backend-tests:
	docker-compose exec backend pytest

docker-check:
	@echo "🔍 Checking Docker status..."
	docker-compose ps
	@echo ""
	@echo "Backend health:"
	-@docker-compose exec backend curl -s http://localhost:8000/docs || echo "Backend not ready"
	@echo ""
	@echo "Running containers:"
	docker ps

ps:
	docker-compose ps

prune:
	docker system prune -a

rebuild:
	docker-compose build --no-cache

restart:
	docker-compose restart
