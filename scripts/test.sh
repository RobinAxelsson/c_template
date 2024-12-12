#!/bin/bash

TEST_BIN_DIR="test/bin"

# Check if the directory exists
if [ ! -d "$TEST_BIN_DIR" ]; then
  echo "Error: Test binaries directory '$TEST_BIN_DIR' does not exist."
  exit 1
fi

passed=1

for test_binary in "$TEST_BIN_DIR"/*; do

  if [ -x "$test_binary" ]; then
    echo
    echo "--------------------------------------------------------------"
    echo "Running test: $test_binary"
    echo "--------------------------------------------------------------"
    "$test_binary"

    if [ $? -ne 0 ]; then
      passed=0
    fi
  else
    echo "Skipping non-executable file: $test_binary"
  fi

done

echo ""
echo "______________________________________________________________"
echo ""

if [ $passed -eq 0 ]; then
    echo "FAIL"
    exit 0
fi

echo PASS