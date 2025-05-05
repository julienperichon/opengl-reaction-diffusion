CC = gcc
CFLAGS = -Wall -g
LIBS = -lglfw -lGL -ldl -lm

# Check for Intel or Apple Silicon Mac
ifeq ($(shell uname), Darwin)
    # Check for Apple Silicon
    ifeq ($(shell uname -m), arm64)
        INCLUDE_DIRS = -I/opt/homebrew/include
        LIB_DIRS = -L/opt/homebrew/lib
    else
        # For Intel Mac
        INCLUDE_DIRS = -I/usr/local/include
        LIB_DIRS = -L/usr/local/lib
    endif
    CFLAGS += $(INCLUDE_DIRS)
    LIBS = $(LIB_DIRS) -lglfw -framework OpenGL -framework Cocoa -framework IOKit -framework CoreVideo
else
    # For Linux
    LIBS = -lglfw -lGL -ldl -lm
endif

all: glad.o triangle

glad.o: glad.c
	$(CC) $(CFLAGS) -c glad.c -o glad.o

triangle: triangle.c glad.o
	$(CC) $(CFLAGS) triangle.c glad.o -o triangle $(LIBS)

clean:
	rm -f triangle glad.o