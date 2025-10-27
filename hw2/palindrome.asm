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

    ; Otherwise, call is_palindrome
    ; TODO push parameters to stack
    call is_palindrome

    jmp prompt_loop

is_palindrome:
    mov eax, SYS_EXIT
    int 0x80

exit_program:
    mov eax, SYS_EXIT
    int 0x80