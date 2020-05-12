#ifndef FAHRENHEIT_TESTS_CPP
#define FAHRENHEIT_TESTS_CPP

#include "../include/doctest.h"
#include "../src/fahrenheit.cpp"

TEST_CASE("Testando conversão de Fahrenheit para Celcius"){
    CHECK(toCelcius(41)==5);
    CHECK(toCelcius(32)==0);
    CHECK(toCelcius(0)==doctest::Approx(-17.777).epsilon(0.0001));
}

#endif
