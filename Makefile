CC = gcc
CFLAGS = -Wall -Wextra -O2 -Iinclude -MMD -MP
SRCS = $(shell find src -name "*.c")
OBJS = $(SRCS:src/%.c=build/%.o)
DEPS = $(OBJS:.o=.d)
TARGET = build/project/prog
.PHONY: all clean
all: $(TARGET)
$(TARGET): $(OBJS) | build/project
	$(CC) $(CFLAGS) $(OBJS) -o $@
build/%.o: src/%.c | build build/utility
	$(CC) $(CFLAGS) -c $< -o $@
build:
	mkdir -p build
build/utility:
	mkdir -p build/utility
build/project:
	mkdir -p build/project
-include $(DEPS)
clean:
	rm -rf build
