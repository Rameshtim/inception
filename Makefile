name = inception

# Ensure 'all' depends on 'images' to build before running
all: images
	@printf "Launch configuration ${name}...\n"
	@docker compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d
	@echo "Application is accessible at https://localhost:443/"

# Define 'images' target for building images
images:
	@printf "Building images for ${name}...\n"
	@docker compose -f ./srcs/docker-compose.yml --env-file srcs/.env build

# Ensure 'build' target depends on 'images' to build before running
build: images
	@printf "Building and running configuration ${name}...\n"
	@docker compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build
	@echo "Application is accessible at https://localhost:443/"

# Define 'down' target to stop containers
down:
	@printf "Stopping configuration ${name}...\n"
	@docker compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

file_del:
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*


# Ensure 're' depends on 'down' to stop before rebuilding
re: down
	@printf "Rebuilding configuration ${name}...\n"
	@docker compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build
	@echo "Application is accessible at https://localhost:443/"

# Ensure 'clean' depends on 'down' to stop before cleaning
clean: down
	@printf "Cleaning configuration ${name}...\n"
	@docker system prune -a

# Define 'fclean' target for full clean
fclean:
	@printf "Total clean of all configurations docker\n"
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

.PHONY: all images build down re clean fclean
