SYS_EXIT equ 1
SYS_WRITE equ 4
SYS_READ equ 3
STDIN equ 0
STDOUT equ 1

SECTION .data
    newLine DB 0xA, 0xD, 0
    newLineLen EQU $-newLine
    addTitle DB "The Adding Program", 0xA, 0xD, 0
    addTitleLen EQU $-addTitle
    userPrompt DB "Please enter a single digit number: "
    lenUserPrompt EQU $-userPrompt
    answerMsg DB "The answer is: "
    lenAnswerMsg EQU $-answerMsg

SECTION .bss
    num1 RESB 2
    num2 RESB 2
    sum RESB 1

section .text
    global _start

_start:
    ; Print "The Adding Program"
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, addTitle
    mov edx, addTitleLen
    int 0x80

    ; Print first number prompt
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, userPrompt
    mov edx, lenUserPrompt
    int 0x80

    ; Retrieve the first number
    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, num1
    mov edx, 2
    int 0x80

    ; Print second number prompt
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, userPrompt
    mov edx, lenUserPrompt
    int 0x80

    ; Retrieve the second number
    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, num2
    mov edx, 2
    int 0x80

    ; Add the two numbers
    mov al, [num1]
    sub al, '0'
    mov bl, [num2]
    sub bl, '0'
    add al, bl
    add al, '0'
    mov [sum], al

    ; Print the answer prompt
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, answerMsg
    mov edx, lenAnswerMsg
    int 0x80

    ; Print the sum
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, sum
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
