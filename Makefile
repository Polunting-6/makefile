CC = gcc
CFLAGS = -Wall -Wextra -O2 -Iinclude

SRCS = src/main.c src/add.c src/sub.c src/utility/stats.c
OBJS = build/main.o build/add.o build/sub.o build/utility/stats.o
TARGET = build/project/prog
.PHONY: all clean
all: prepare $(TARGET)
prepare:
	mkdir -p build/utility build/project

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $(TARGET)
build/main.o: src/main.c
	$(CC) $(CFLAGS) -c src/main.c -o build/main.o
build/add.o: src/add.c
	$(CC) $(CFLAGS) -c src/add.c -o build/add.o
build/sub.o: src/sub.c
	$(CC) $(CFLAGS) -c src/sub.c -o build/sub.o
build/utility/stats.o: src/utility/stats.c
	$(CC) $(CFLAGS) -c src/utility/stats.c -o build/utility/stats.o
clean:
	rm -rf build

