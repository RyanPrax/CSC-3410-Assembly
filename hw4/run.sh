nasm -g -f elf32 -F dwarf -o functions.o functions.asm
gcc -g -Wall -static -m32 -o backandforth backandforth.c functions.o