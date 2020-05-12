#ifndef FACTORIAL_CPP
#define FACTORIAL_CPP

#include <iostream>

using namespace std;

int factorial(int number) { 
    return number <= 1 ? number : factorial(number - 1) * number; 
}

#endif