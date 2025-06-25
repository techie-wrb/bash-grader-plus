#!/bin/bash

INPUT="test_cases/input1.txt"
EXPECTED="test_cases/output1.txt"
OUTPUT_DIR="results"
LOG_DIR="logs"
mkdir -p "$OUTPUT_DIR" "$LOG_DIR"

echo "Student,Score,Remarks" > "$OUTPUT_DIR/report.csv"

for file in submissions/*; do
    filename=$(basename -- "$file")
    name="${filename%.*}"
    ext="${filename##*.}"

    exec_file="logs/$name.out"
    log_file="logs/$name.log"
    actual="logs/${name}.output1.txt"

    # Compile
    if [ "$ext" == "c" ]; then
        gcc "$file" -o "$exec_file" &> "$log_file"
    elif [ "$ext" == "cpp" ]; then
        g++ "$file" -o "$exec_file" &> "$log_file"
    else
        echo "$name,0,Invalid extension" >> "$OUTPUT_DIR/report.csv"
        continue
    fi

    if [ ! -f "$exec_file" ]; then
        echo "$name,0,Compilation Error" >> "$OUTPUT_DIR/report.csv"
        continue
    fi

    # Run test
    timeout 2s "$exec_file" < "$INPUT" > "$actual"

    # Compare
    if diff -q "$actual" "$EXPECTED" > /dev/null; then
        echo "$name,1,Test1: Pass" >> "$OUTPUT_DIR/report.csv"
    else
        echo "$name,0,Test1: Fail" >> "$OUTPUT_DIR/report.csv"
    fi
done
