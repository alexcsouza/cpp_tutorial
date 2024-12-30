#ifndef MAIN_CPP
#define MAIN_CPP

#include <iostream>
#include <stdlib.h>
#include <stdio.h>

#include "factorial.cpp"
#include "fahrenheit.cpp"

using namespace std;

int main(int argc, char* argv[]){
    cout << "[App] " << argc << " " << *argv << endl;

    if(argc < 1){
        cout << "Error: Invalid argument (NULL) ";
    
        return 1;
    }

    double arg = atof(argv[1]);
    
    cout << "Factorial: " << factorial(arg) << endl;
    cout << "To Fahrenheit: " << toFahrenheit(arg) << endl;
    
    return 0;
}

#endif