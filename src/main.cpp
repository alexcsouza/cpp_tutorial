#ifndef MAIN_CPP
#define MAIN_CPP

#include <iostream>

#include "factorial.cpp"
#include "fahrenheit.cpp"

using namespace std;

int main(int argc, char** argv){
    cout << "[App] " << argc << " " << *argv << endl;
    cout << "Factorial: " << factorial(argc) << endl;
    cout << "To Fahrenheit: " << toFahrennheit(argc) << endl;
    return 0;
}

#endif