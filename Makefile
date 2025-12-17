# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: vviterbo <vviterbo@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/11/22 22:31:07 by victorviter       #+#    #+#              #
#    Updated: 2025/12/11 13:34:11 by vviterbo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME		=	Inception

all			:	$(NAME)

up			:	$(NAME)

DB_VOLUME 	=	/home/vviterbo/data/dummydb/
WP_VOLUME	=	/home/vviterbo/data/dummysite/

db_volume_ok = $(shell docker volume ls | grep "db-volume" | wc -l)
wp_volume_ok = $(shell docker volume ls | grep "wordpress-volume" | wc -l)


$(NAME)		:	
				@mkdir -p ${DB_VOLUME}
				@mkdir -p ${WP_VOLUME}
				
				@if [ $(strip $(db_volume_ok)) -eq 0 ]; then docker volume create  --name db-volume --driver local --opt type=none --opt device=$(DB_VOLUME) --opt o=bind; \
				fi
					
				@if [ $(strip $(wp_volume_ok)) -eq 0 ]; then docker volume create  --name wordpress-volume --driver local  --opt type=none --opt device=$(WP_VOLUME) --opt o=bind; \
				fi

				docker compose  -f ./srcs/docker-compose.yml up -d
				
				@make -s header
				@printf "$(COLOR_G)[OK] $(NAME) is ready!$(C_RESET)\n" || \
				printf "$(COLOR_R)[KO] Something went wrong.$(C_RESET)\n"

down		:
				docker compose -f srcs/docker-compose.yml down

re			: down up

deepre		:
				docker compose -f srcs/docker-compose.yml down
				
				docker volume rm db-volume
				docker volume rm wordpress-volume
				rm -fr ${DB_VOLUME}/*
				rm -fr ${WP_VOLUME}/*
				docker volume create  --name db-volume --driver local --opt type=none --opt device=${DB_VOLUME} --opt o=bind;
				docker volume create  --name wordpress-volume --driver local  --opt type=none --opt device=${WP_VOLUME} --opt o=bind;
				
				docker compose -f srcs/docker-compose.yml build --no-cache
				docker compose -f srcs/docker-compose.yml up -d

.PHONY		:	all clean re
.SILENT		:	all $(NAME)clean fclean

COLOR_R		= \033[31m
COLOR_O		= \033[38;5;214m
COLOR_Y		= \033[33m
COLOR_G		= \033[32m
COLOR_B		= \033[34m
COLOR_V		= \033[38;5;93m
COLOR_I		= \033[3m
C_RESET		= \033[0m

header	:
			printf "=========================================================\n"
			printf "$(COLOR_O) ___                      _   _               _ $(C_RESET)\n"
			printf "$(COLOR_R)|_ _|_ __   ___ ___ _ __ | |_(_) ___  _ __   | |$(C_RESET)\n"
			printf "$(COLOR_G) | || '_ \ / __/ _ \ '_ \| __| |/ _ \| '_ \  | |$(C_RESET)\n"
			printf "$(COLOR_Y) | || | | | (_|  __/ |_) | |_| | (_) | | | | |_|$(C_RESET)\n"
			printf "$(COLOR_B)|___|_| |_|\___\___| .__/ \__|_|\___/|_| |_| (_)$(C_RESET)\n"
			printf "$(COLOR_V)                   |_|                          $(C_RESET)\n"
			printf "$(COLOR_I)    				      by vviterbo$(C_RESET)\n"
			printf "=========================================================\n"
