#ifndef FAHRENHEIT_CPP
#define FAHRENHEIT_CPP

#include <iostream>

using namespace std;

double toCelcius(double fahrenheit){
    cout << "Calling toCelcius: " << fahrenheit << endl;
    return (fahrenheit - 32) * 5/9;
}

double toFahrennheit(double celcius){
    cout << "Calling toFahrennheit: " << celcius << endl;
    return (9/5 * celcius) + 32;
}

#endif