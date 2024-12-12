# run make with debug: make -d

CC = gcc
CFLAGS = -Wall -Wextra -I./src
SRC_DIR = src
BIN_DIR = src/bin
OBJ_DIR = src/obj
OUT = a.out

SRC_FILES = $(wildcard $(SRC_DIR)/*.c)
OBJ_FILES = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRC_FILES))

# all: $(BIN_DIR)/$(OUT)

# Link the project executable from object files
$(BIN_DIR)/$(OUT): $(OBJ_FILES)
	mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -o $@ $^

# Compile source files into object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	mkdir -p $(BIN_DIR)
	mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

TEST_DIR = test
BIN_TEST = test/bin
TEST_FILES = $(wildcard $(TEST_DIR)/*.c)
TEST_OBJ_FILES = $(patsubst $(TEST_DIR)/%.c, $(BIN_TEST)/%.o, $(TEST_FILES))
NON_MAIN_SRC_FILES = $(filter-out $(SRC_DIR)/main.c, $(SRC_FILES)) # exclude main

# Test target
test: $(BIN_TEST)/math_utils_tests

# Compile test files into executables
$(BIN_TEST)/math_utils_tests: $(TEST_FILES) $(NON_MAIN_SRC_FILES)
	mkdir -p $(BIN_TEST)
	$(CC) $(CFLAGS) -o $@ $(TEST_FILES) $(NON_MAIN_SRC_FILES)

clean:
	rm -rf $(BIN_DIR)
	rm -rf $(BIN_TEST)