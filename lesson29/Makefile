.PHONY: help up down restart logs clean setup

help:
	@echo "Available commands:"
	@echo "  make setup    - Setup directories and start services"
	@echo "  make up       - Start all services"
	@echo "  make down     - Stop all services"
	@echo "  make restart  - Restart all services"
	@echo "  make logs     - View logs"
	@echo "  make clean    - Stop services and remove volumes"

setup:
	@mkdir -p prometheus grafana/dashboards grafana/datasources blackbox
	@chmod +x setup.sh
	@./setup.sh

up:
	docker-compose up -d

down:
	docker-compose down

restart:
	docker-compose restart

logs:
	docker-compose logs -f

clean:
	docker-compose down -v
	@echo "All containers and volumes removed"
