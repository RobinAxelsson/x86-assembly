// equals_tests.c
#include <stdio.h>
//main is at end of file for convinience

//externs are written in x86 assembly
extern long decimal_parse(char* string);
extern long strlen(char* string);
extern long get_decimal_i(char* string, long index);
extern long mul10(long number, char power);


int passed = 0;
int tests = 0;

char* apply_result(int boolean_result)
{
    tests++;
    char* fail = "";

    if(!boolean_result){
        fail = " - FAILED";
    }
    else {
        passed++;
    }

    return fail;
}

void decimal_parse_1_1()
{
    char* input = "1\0";
    char res = decimal_parse(input);
    char exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, decimal_parse_1_1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void decimal_parse_11_11()
{
    char* input = "21\0";
    long res = decimal_parse(input);
    long exp = 21;
    char *fail = apply_result(exp == res);

    printf("%d, decimal_parse_11_11 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void strlen_abc_3(){
    char* input = "abc\0";
    long res = strlen(input);
    long exp = 3;
    char *fail = apply_result(exp == res);

    printf("%d, strlen_abc_3 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void get_decimal_i_123_1(){
    char* input = "123";
    long res = get_decimal_i(input, 0);
    long exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, get_decimal_i_123_1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void get_decimal_i_123_2(){
    char* input = "123";
    long res = get_decimal_i(input, 1);
    long exp = 2;
    char *fail = apply_result(exp == res);

    printf("%d, get_decimal_i_123_2 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void get_decimal_i_123_3(){
    char* input = "123";
    long res = get_decimal_i(input, 2);
    long exp = 3;
    char *fail = apply_result(exp == res);

    printf("%d, get_decimal_i_123_3 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void strlen_null_0(){
    char* input = "\0";
    long res = strlen(input);
    long exp = 0;
    char *fail = apply_result(exp == res);

    printf("%d, strlen_null_0 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void mul10_5and2_500(){
    long number = 5;
    char power = 3;
    long res = mul10(number, power);
    long exp = 5000;
    char *fail = apply_result(exp == res);

    printf("%d, mul10_5and2_500 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void mul10_5and0_5(){
    long number = 5;
    char power = 0;
    long res = mul10(number, power);
    long exp = 5;
    char *fail = apply_result(exp == res);

    printf("%d, mul10_5and0_5 - expected: %d result: %d %s\n", tests, exp, res, fail);
}


int main() 
{
    decimal_parse_1_1();
    decimal_parse_11_11();
    strlen_abc_3();
    strlen_null_0();
    get_decimal_i_123_1();
    get_decimal_i_123_2();
    get_decimal_i_123_3();
    mul10_5and2_500();
    mul10_5and0_5();
    //Summary
    printf("---------------------------------------\n");
    printf("\n%d/%d tests passed!\n", passed, tests);

    if(passed == tests)
        return 0;
    
    return 1;
}