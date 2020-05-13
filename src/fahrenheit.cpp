#ifndef FAHRENHEIT_CPP
#define FAHRENHEIT_CPP

#include <iostream>

using namespace std;

double toCelcius(double fahrenheit){
    return (fahrenheit - 32) * 5/9;
}

double toFahrenheit(double celcius){
    return 1.8 * celcius + 32;
}

#endif