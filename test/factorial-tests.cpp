#ifndef FACTORIAL_TESTS
#define FACTORIAL_TESTS

#include <iostream>
#include "../include/doctest.h"
#include "../src/factorial.cpp"

using namespace std;
TEST_CASE("testing the factorial function") {
    CHECK(factorial(1) == 1);
    CHECK(factorial(2) == 2);
    CHECK(factorial(3) == 6);
    CHECK(factorial(10) == 3628800);
}

#endif