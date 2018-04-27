#!/usr/bin/env bash
# compile regex dll
g++ -c -DBUILDING_EXAMPLE_DLL regex.cpp -o regex.o
g++ -shared regex.o -o regex.dll
rm regex.o
# compile test exe
g++ test.cpp -o test -L. -lregex
