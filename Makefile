#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: vmonteco <vmonteco@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/03/14 22:03:24 by vmonteco          #+#    #+#              #
#    Updated: 2024/03/14 22:17:36 by vmonteco         ###   ########.fr        #
#                                                                              #
#******************************************************************************#

# Related to the shared library generation :
STATIC_LIBRARY =				./libasm.a
SHARED_LIBRARY =				./libasm.so
CC =							gcc
CFLAGS =						-Wall -Werror -Wextra
STATIC_LIBRARY_MAKEFILE_DIR =	/path/to/libasm_project
REMOTE_LIBASM =					$(STATIC_LIBARY_MAKEFILE_DIR)/libasm.a
REMOTE_MAKE_RULE =				# EMPTY

ifeq ($(UNAME_S),Linux)
	CFLAGS+ =					-Wl,--whole-archive
	CLOSING =					-Wl,--no-whole-archive
else
	CFLAGS						=-Wl,-all_load
	CLOSING =					# empty
endif

all: test

$(SHARED_LIBRARY): $(STATIC_LIBRARY)
	$(CC) -shared -o $@ $(CFLAGS) $< $(CLOSING)

$(STATIC_LIBRARY):
	make -C fclean
	make -C $(STATIC_LIBRARY_MAKEFILE_DIR) $(REMOTE_MAKE_RULE)
	cp $(STATIC_LIBRARY_MAKEFILE_DIR)/libasm.a $@

test: $(SHARED_LIBARY)
	pytest

test_bonus: export REMOTE_MAKE_RULE=bonus $(SHARED_LIBRARY)

clean:
	rm $(CLEAN_FILES)

fclean: clean

re: fclean all

.PHONY: test test_bonus clean fclean re all
