SYS_EXIT equ 1
SYS_WRITE equ 4
SYS_READ equ 3
STDIN equ 0
STDOUT equ 1

SECTION .data
    newLine DB 0xA, 0xD, 0
    newLineLen EQU $-newLine

    prompt DB "Please enter a string", 0xA, 0xD, 0
    promptLen EQU $-prompt

    itIs DB "It is a palindrome", 0xA, 0xD, 0
    itIsLen EQU $-itIs

    itIsNot DB "It is NOT a palindrome", 0xA, 0xD, 0
    itIsNotLen EQU $-itIs

SECTION .bss
    buffer RESB 1024

SECTION .text
    global _start

_start:
prompt_loop:
    ; Print Prompt
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, prompt
    mov edx, promptLen
    int 0x80

    ; Retrieve the string
    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, buffer
    mov edx, 1024
    int 0x80

    ; Check if input is only a newline (empty input)
    cmp BYTE [buffer], 0xA
    je exit_program

    dec eax ; Remove \n from length
    push eax ; Push length of input to the stack
    push buffer ; Push the actual message to the stack
    call is_palindrome ; Check if the message is a palindrome (auto true for now)
    add esp, 8 ; Bring back the stack (2 parameters, 4 bytes each)

    cmp eax, 1 ; is_palindrome returns 1 if palindrome
    je print_palindrome
    jmp print_not_palindrome

is_palindrome:
    mov eax, 1
    ;mov eax, SYS_EXIT
    ;int 0x80


print_palindrome:
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, itIs
    mov edx, itIsLen
    int 0x80
    jmp prompt_loop

print_not_palindrome:
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, itIsNot
    mov edx, itIsNotLen
    int 0x80
    jmp prompt_loop

exit_program:
    mov eax, SYS_EXIT
    int 0x80