CC=gcc
SRC=$(wildcard ./src/*.c)
HEADERS=$(wildcard ./src/*.h)
CFLAGS=-Ithirdparty/includes -O3 -Wall -Wextra -Werror -Wno-absolute-value -Wno-sign-compare -pedantic
DFLAGS=-Ithirdparty/includes -O0 -g -Wall -Wextra -Wno-absolute-value -Wno-sign-compare -pedantic
LFLAGS=
DEFS=
BUILD=build
EXE=$(BUILD)/wrun
DEBUG=$(BUILD)/wrun-debug
PLATFORM=linux

ifeq ($(OS),Windows_NT)
	PLATFORM=windows
endif

ifeq ($(PLATFORM),windows)
	LFLAGS+=-static -Lthirdparty/libs/win -lm -lraylib -lopengl32 -lgdi32 -lwinmm -lwinpthread -Wl,--subsystem,windows
else
	LFLAGS+=-Lthirdparty/libs/linux -lm -lraylib -lX11 -lglfw
endif

all: $(BUILD) $(EXE) $(DEBUG)

$(EXE): $(SRC) $(HEADERS)
	$(CC) $(CFLAGS) -o $(EXE) $(SRC) $(LFLAGS)

$(DEBUG): $(SRC) $(HEADERS)
	$(CC) $(DFLAGS) -o $(DEBUG) $(SRC) $(LFLAGS)

run: $(EXE)
	./$(EXE)

debug: $(DEBUG)
	./$(DEBUG)

$(BUILD):
	mkdir -p $(BUILD)

.PHONY: clean
clean:
	rm -rf $(BUILD)
