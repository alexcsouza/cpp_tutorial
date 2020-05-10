#ifndef FAHRENHEIT_TEST
#define FAHRENHEIT_TEST

#include "../include/doctest.h"
#include "../src/fahrenheit.cpp"

TEST_CASE("Testando conversão de Fahrenheit para Celcius"){

    CHECK(converte_grau(41)==5);
}

#endif
