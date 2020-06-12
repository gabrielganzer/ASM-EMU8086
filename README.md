## EMU8086 ##

# crypt.asm #

Program in 8086 assembly that takes as input a short text of 4 lines, each of these lines long from 20 to 50 characters. It counts the number of occurrences of each letter and outputs the maximum. Caesar cipher is used as cryptographic algorithm.

# matrix.asm #

Program in 8086 assembly for multiplying two matrices whose elements are signed numbers expressed with one byte. First matrix has N rows and M columns. Second matrix has M rows and P columns. The result is a matrix with N rows and P columns. The matrix contains sign numbers expressed with one word. N, M, P are constants defined with EQU.

# matrix_overflow.asm #

Program in 8086 assembly for multiplying two matrices while managing overflow. If the result after the overflow is positive, it must be replaced with the minimum negative number representable in one word (-32768). If the result after the overflow is negative, it must be replaced with the maximum positive number representable in one word (32767).