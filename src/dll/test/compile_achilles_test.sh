#!/bin/bash
########################################
# setting up example dll with cygwin
########################################
gcc64="x86_64-w64-mingw32-gcc"
gcc32="i686-w64-mingw32-gcc"

$gcc64 -c achilles_test_dll.c -o achilles_test_dll_x64.o
$gcc64 -shared achilles_test_dll_x64.o -o achilles_test_dll_x64.dll
$gcc64 achilles_test_linker.c -o achilles_test_linker_x64 -L "$PWD" -lachilles_test_dll_x64
./achilles_test_linker_x64.exe
$gcc64 achilles_test_loader.c -o achilles_test_loader_x64
./achilles_test_loader_x64.exe
$gcc32 -c achilles_test_dll.c -o achilles_test_dll.o
$gcc32 -shared achilles_test_dll.o -o achilles_test_dll.dll
$gcc32 achilles_test_linker.c -o achilles_test_linker -L "$PWD" -lachilles_test_dll
./achilles_test_linker.exe
$gcc32 achilles_test_loader.c -o achilles_test_loader
./achilles_test_loader.exe
cp {achilles_test_dll_x64.dll,achilles_test_dll.dll} ../../../@AresModAchillesExpansion/.