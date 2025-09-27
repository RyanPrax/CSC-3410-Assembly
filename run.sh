#nasm -g -f elf -F dwarf -o p1.o p1.asm
#ld p1.o -m elf_i386 -o p1
#./p1

nasm -g -f elf -F dwarf -o p2.o p2.asm
ld p2.o -m elf_i386 -o p2
./p2