#!/bin/bash

student_file=$1

mkdir -p logs results

score=0
remarks=""
total=$(jq length test_cases/test_cases.json)

gcc "$student_file" -o "logs/$student_name.out" &> logs/compile_log.txt
if [ $? -ne 0 ]; then
    remarks="Compilation Error"
    echo "Student,Score,Remarks" > results/report.csv
    echo "$student_name,0,\"$remarks\"" >> results/report.csv
    exit 0
fi

for ((i=0; i<$total; i++)); do
    input=$(jq -r ".[$i].input" test_cases/test_cases.json)
    expected_output=$(jq -r ".[$i].output" test_cases/test_cases.json)

    actual_output=$(echo "$input" | ./logs/$student_name.out)
    
    if [[ "$actual_output" == "$expected_output" ]]; then
        remarks+="Test$((i+1)): Pass; "
        score=$((score+10))
    else
        remarks+="Test$((i+1)): Fail; "
    fi
done

echo "Student,Score,Remarks" > results/report.csv
echo "$student_name,$score,\"$remarks\"" >> results/report.csv
