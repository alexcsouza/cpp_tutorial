#ifndef FAHRENHEIT_CPP
#define FAHRENHEIT_CPP

#include <iostream>

using namespace std;

double toCelsius(double fahrenheit){
    return (fahrenheit - 32) * 5/9;
}

double toFahrenheit(double celsius){
    return 1.8 * celsius + 32;
}

#endif