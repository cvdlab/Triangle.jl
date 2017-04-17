CC = gcc # C compiler
CFLAGS = -fPIC -Wall -Wextra -O2 -g # C flags
LDFLAGS = -shared  # linking flags
RM = rm -f  # rm command
TARGET_LIB = libtriangle.so # target lib

SRCS = tricall.c triangle.c # source files
OBJS = $(SRCS:.c=.o)

ifeq ($(OS),Windows_NT)
    CFLAGS += -DCPU86
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        CFLAGS += -DLINUX
    endif
    ifeq ($(UNAME_S),Darwin)
        LDFLAGS = -dynamiclib -undefined suppress -flat_namespace
    endif
endif

.PHONY: all
all: ${TARGET_LIB}

$(TARGET_LIB): $(OBJS)
	$(CC) ${LDFLAGS} -o $@ $^

$(SRCS:.c=.d):%.d:%.c
	$(CC) $(CFLAGS) -MM $< >$@

include $(SRCS:.c=.d)

.PHONY: clean
clean:
	-${RM} ${TARGET_LIB} ${OBJS} $(SRCS:.c=.d)