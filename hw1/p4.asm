SYS_EXIT equ 1
SYS_WRITE equ 4
SYS_READ equ 3
STDIN equ 0
STDOUT equ 1

SECTION .data
    newLine DB 0xA, 0xD, 0
    newLineLen EQU $-newLine

    swappingTitle DB "The Swapping Program", 0xA, 0xD, 0
    swappingTitleLen EQU $-swappingTitle

    userPrompt DB "Please enter a two character string: "
    lenUserPrompt EQU $-userPrompt
    
    answerMsg DB "The answer is: "
    lenAnswerMsg EQU $-answerMsg

SECTION .bss
    two_char_string RESB 3

section .text
    global _start

_start:
    ; Print "The Swapping Program"
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, swappingTitle
    mov edx, swappingTitleLen
    int 0x80

    ; Print the user prompt
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, userPrompt
    mov edx, lenUserPrompt
    int 0x80

    ; Retrieve the two character string
    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, two_char_string
    mov edx, 3
    int 0x80

    ; Reverse the string
    mov al, [two_char_string]
    mov bl, [two_char_string + 1]
    mov [two_char_string], bl
    mov [two_char_string + 1], al

    ; Print the answer message
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, answerMsg
    mov edx, lenAnswerMsg
    int 0x80

    ; Print the reversed string
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, two_char_string
    mov edx, 2
    int 0x80

    ; Print New Line
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, newLine
    mov edx, newLineLen
    int 0x80

    mov eax, SYS_EXIT
    int 0x80
