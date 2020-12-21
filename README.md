## ASM-EMU8086 ##
[![SHIELDS](https://img.shields.io/badge/development-completed-green)](https://shields.io/)

## PROJECT DESCRIPTION

This project includes sime small assembly programs developed throughout the Computer Architectures 19/20 course at Politecnico di Torino targeting the Intel 8086 emulator:

* **crypt.asm**: rogram in 8086 assembly that takes as input a short text of 4 lines, each of these lines long from 20 to 50 characters. It counts the number of occurrences of each letter and outputs the maximum. Caesar cipher is used as cryptographic algorithm.

* **matrix.asm**: rogram in 8086 assembly for multiplying two matrices whose elements are signed numbers expressed with one byte. First matrix has N rows and M columns. Second matrix has M rows and P columns. The result is a matrix with N rows and P columns. The matrix contains sign numbers expressed with one word. N, M, P are constants defined with EQU.

* **matrix_overflow.asm**: program in 8086 assembly for multiplying two matrices while managing overflow. If the result after the overflow is positive, it must be replaced with the minimum negative number representable in one word (-32768). If the result after the overflow is negative, it must be replaced with the maximum positive number representable in one word (32767).

## DOCUMENTATION

Source files for each program can be found inside the respective folder.

## LICENSE

The source code of the project is licensed under the GPLv3 license, unless otherwise stated. 
