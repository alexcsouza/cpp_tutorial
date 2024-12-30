#ifndef FAHRENHEIT_TESTS_CPP
#define FAHRENHEIT_TESTS_CPP

#include "../include/doctest.h"
#include "../src/fahrenheit.cpp"

TEST_CASE("Testando conversão de Celsius para Fahrenheit"){
    CHECK(toCelsius(41)==5);
    CHECK(toCelsius(32)==0);
    CHECK(toCelsius(0)==doctest::Approx(-17.777).epsilon(0.0001));
}

TEST_CASE("Testando conversão de Fahrenheit para Celsius"){
    CHECK(toFahrenheit(5.00)==41);
    CHECK(toFahrenheit(0.00)==32);
    CHECK(toFahrenheit(-17.7777)==doctest::Approx(0).epsilon(0.001));
}

#endif
