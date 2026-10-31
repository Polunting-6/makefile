CC = gcc
CFLAGS = -Wall -Wextra -O2 -Iinclude -MMD -MP
SRCS_STATIC = src/main.c src/add.c src/sub.c src/utility/stats.c
SRCS = $(SRCS_STATIC) src/mul.c
OBJS = $(SRCS:src/%.c=build/%.o)
DEPS = $(OBJS:.o=.d)
TARGET = build/calc
GENERATOR = build/genmul
.PHONY: all clean test
all: $(TARGET)
$(TARGET): $(OBJS) | build
	$(CC) $(CFLAGS) $(OBJS) -o $@
$(GENERATOR): tools/genmul.c | build
	$(CC) $(CFLAGS) $< -o $@
include/mul.h: $(GENERATOR)
	./$(GENERATOR)
src/mul.c: include/mul.h
	@touch $@
build/mul.o: src/mul.c include/mul.h | build build/utility
	$(CC) $(CFLAGS) -c src/mul.c -o $@
build/%.o: src/%.c | build build/utility
	$(CC) $(CFLAGS) -c $< -o $@
build:
	mkdir -p build
build/utility:
	mkdir -p build/utility
-include $(DEPS)
test: $(TARGET)
	./tests/test.sh
clean:
	rm -rf build
	rm -f src/mul.c include/mul.h
