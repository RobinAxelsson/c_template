#Note no spaces allowed in file names

CC = gcc
CFLAGS = -Wall -Wextra -I./src
OUT = a.out
SRC_DIR = src
BIN_DIR = src/bin
OBJ_DIR = src/obj
TEST_DIR = test
TEST_BIN_DIR = test/bin
TEST_OBJ_DIR = test/obj

SRC_FILES = $(wildcard $(SRC_DIR)/*.c)
OBJ_FILES = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRC_FILES))
TEST_FILES = $(wildcard $(TEST_DIR)/*.c)
TEST_OBJ_FILES = $(patsubst $(TEST_DIR)/%.c, $(TEST_OBJ_DIR)/%.o, $(TEST_FILES))
TEST_BINARIES = $(patsubst $(TEST_DIR)/%.c, $(TEST_BIN_DIR)/%, $(TEST_FILES))
NON_MAIN_SRC_FILES = $(filter-out $(SRC_DIR)/main.c, $(SRC_FILES))

# Directories
DIRS = $(BIN_DIR) $(OBJ_DIR) $(TEST_BIN_DIR) $(TEST_OBJ_DIR)

# Default target
all: $(BIN_DIR)/$(OUT)

# Create necessary directories
$(DIRS):
	mkdir -p $@

# Link the project executable
$(BIN_DIR)/$(OUT): $(OBJ_FILES) | $(BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $^

# Compile source files into object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Test target
test: $(TEST_BINARIES)

# Compile each test source file into a separate executable
$(TEST_BIN_DIR)/%: $(TEST_OBJ_DIR)/%.o $(NON_MAIN_SRC_FILES) | $(TEST_BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $< $(NON_MAIN_SRC_FILES)

# Compile test object files
$(TEST_OBJ_DIR)/%.o: $(TEST_DIR)/%.c | $(TEST_OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Ensure test binaries depend on object files
$(TEST_BINARIES): $(TEST_OBJ_FILES)

# Clean up
.PHONY: clean
clean:
	rm -rf $(BIN_DIR) $(OBJ_DIR) $(TEST_BIN_DIR) $(TEST_OBJ_DIR)
