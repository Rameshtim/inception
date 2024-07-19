name = inception

# ANSI color codes and text styles
GREEN = \033[0;32m
RED = \033[0;31m
YELLOW = \033[0;33m
BOLD = \033[1m
NC = \033[0m # No Color

# Ensure 'all' depends on 'images' to build before running
all: images
	@printf "${BOLD}${GREEN}Launch configuration ${name}...${NC}\n"
	@docker compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d
	@printf "${BOLD}${YELLOW}Setting up WordPress, please wait ....${NC}\n"
	@for i in 1 2 3 4 5 6 7 8 9 10; do \
		if [ $$((i % 2)) -eq 0 ]; then \
			printf "${GREEN} => ${NC}"; \
		else \
			printf "${RED} => ${NC}"; \
		fi; \
		sleep 2; \
	done
	@printf "\n"
	@echo "${BOLD}${GREEN}Application is accessible at https://localhost:443/${NC}"

# Define 'images' target for building images
images:
	@printf "${BOLD}${GREEN}Building images for ${name}...${NC}\n"
	@docker compose -f ./srcs/docker-compose.yml --env-file srcs/.env build

# Ensure 'build' target depends on 'images' to build before running
build: images
	@printf "${BOLD}${GREEN}Building and running configuration ${name}...${NC}\n"
	@docker compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build
	@printf "${BOLD}${YELLOW}Setting up WordPress, please wait ....${NC}\n"
	@for i in 1 2 3 4 5 6 7 8 9 10; do \
		if [ $$((i % 2)) -eq 0 ]; then \
			printf "${GREEN} => ${NC}"; \
		else \
			printf "${RED} => ${NC}"; \
		fi; \
		sleep 2; \
	done
	@printf "\n"
	@echo "${BOLD}${GREEN}Application is accessible at https://localhost:443/${NC}"

# Define 'down' target to stop containers
down:
	@printf "${BOLD}${GREEN}Stopping configuration ${name}...${NC}\n"
	@docker compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

file_del:
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

# Ensure 're' depends on 'down' to stop before rebuilding
re: down
	@printf "${BOLD}${GREEN}Rebuilding configuration ${name}...${NC}\n"
	@docker compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build
	@printf "${BOLD}${YELLOW}Setting up WordPress, please wait ....${NC}\n"
	@for i in 1 2 3 4 5 6 7 8 9 10; do \
		if [ $$((i % 2)) -eq 0 ]; then \
			printf "${GREEN} => ${NC}"; \
		else \
			printf "${RED} => ${NC}"; \
		fi; \
		sleep 2; \
	done
	@printf "\n"
	@echo "${BOLD}${GREEN}Application is accessible at https://localhost:443/${NC}"

# Ensure 'clean' depends on 'down' to stop before cleaning
clean: down
	@printf "${BOLD}${GREEN}Cleaning configuration ${name}...${NC}\n"
	@docker system prune -a

# Define 'fclean' target for full clean
fclean:
	@printf "${BOLD}${GREEN}Total clean of all configurations docker${NC}\n"
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

.PHONY: all images build down re clean fclean