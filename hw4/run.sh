nasm -g -f elf32 -F dwarf -o functions.o functions.asm
gcc -g -Wall -static -m32 -z noexecstack -o backandforth backandforth.c functions.o
./backandforth