#ifndef FACTORIAL_CPP
#define FACTORIAL_CPP

#include <iostream>

using namespace std;

double factorial(double number) { 
    return number <= 1 ? number : factorial(number - 1) * number; 
}

#endif