echo "Compiling and linking Program 1, the adding program"
nasm -g -f elf -F dwarf -o p1.o p1.asm
ld p1.o -m elf_i386 -o p1
echo "Running Program 1"
echo
./p1

echo "========================================================"
echo "Compiling and linking Program 2, the multiplying program"
nasm -g -f elf -F dwarf -o p2.o p2.asm
ld p2.o -m elf_i386 -o p2
echo "Running Program 2"
echo
./p2

echo "========================================================"
echo "Compiling and linking Program 3, the dividing program"
nasm -g -f elf -F dwarf -o p3.o p3.asm
ld p3.o -m elf_i386 -o p3
echo "Running Program 3"
echo
./p3

echo "========================================================"
echo "Compiling and linking Program 4, the swapping program"
nasm -g -f elf -F dwarf -o p4.o p4.asm
ld p4.o -m elf_i386 -o p4
echo "Running Program 4"
echo
./p4