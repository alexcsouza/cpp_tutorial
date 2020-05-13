#ifndef MAIN_CPP
#define MAIN_CPP

#include <iostream>

#include "factorial.cpp"
#include "fahrenheit.cpp"

using namespace std;

int main(int argc, char* argv[]){
    cout << "[App] " << argc << " " << *argv << endl;
    cout << "Factorial: " << factorial(*argv[1]) << endl;
    cout << "To Fahrenheit: " << toFahrenheit(*argv[1]) << endl;
    return 0;
}

#endif