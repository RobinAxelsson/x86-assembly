#!/bin/bash

# prefer to send it to std out (echo)
# build in test.sh

#-----TEST-SETUP-----

tests=0
passed=0
gdb=0

if [[ "$1" == "-g" || "$2" == "-g" ]]; then
    gdb=1
fi

run_exit_test(){
    [ "gdb" == 1 ] && eval gdb -q --args "$1" || eval "$1" # test-expression
    
    res="$?"
    exp="$2"

    ((tests++))
    if [ $exp -eq $res ]; then
        ((passed++))   # (()) is for aritmetics, no $ needed
    else 
        fail="<------ FAILED"
    fi

    echo "$1 res=$res exp=$exp $fail"
    fail=""
}

run_output_test(){
    res=""

    if [ "$gdb" == 1 ]; then
        gdb -q --args ./output/x86Calc "$1"
        exit 0
    else
        res=$("./output/x86Calc" "$1")
    fi

    exp="$2"

    ((tests++))
    if [ "$exp" -eq "$res" ]; then
        ((passed++))   # (()) is for aritmetics, no $ needed
    else 
        fail="<------ FAILED"
    fi

    echo "$1 res=$res exp=$exp $fail"
    fail=""
}

#-------TESTS--------

# wrong input expect fail
# $? is return value for any function or command (exit status)
run_exit_test "./output/x86Calc" "1"
run_exit_test "./output/x86Calc 11" "1"

run_output_test "6/3" 2

run_output_test "1+1" 2
run_output_test "1+2" 3
run_output_test "13+6" 19
run_output_test "1000+0" 1000

run_output_test "1-1" 0
run_output_test "3-1" 2
run_output_test "10-1" 9
run_output_test "1-10" "-9"
run_output_test "10-15" "-5"

run_output_test "1*2" 2
run_output_test "9*11" 99
run_output_test "123456*100" 12345600
run_output_test "0*100" 0
# run_output_test "0*-100" 0

run_output_test "10/2" 5
run_output_test "100/5" 20
run_output_test "100/3" 33
run_output_test "99/11" 9

#-------SUMMARY------
echo "--------------------------"
echo "$passed"/"$tests" passed

if [ $passed -ne $tests ]; then
    exit 1
fi