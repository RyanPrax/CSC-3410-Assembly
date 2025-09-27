SYS_EXIT equ 1
SYS_WRITE equ 4
SYS_READ equ 3
STDIN equ 0
STDOUT equ 1

SECTION .data
    newLine DB 0xA, 0xD, 0
    newLineLen EQU $-newLine

    dividingTitle DB "The Dividing Program", 0xA, 0xD, 0
    dividingTitleLen EQU $-dividingTitle

    userPrompt DB "Please enter a single digit number: "
    lenUserPrompt EQU $-userPrompt

    quotientMsg DB "The Quotient is: "
    lenQuotientMsg EQU $-quotientMsg
    
    remainderMsg DB "The remainder is: "
    lenRemainderMsg EQU $-remainderMsg

SECTION .bss
    num1 RESB 2
    num2 RESB 2
    quotient RESB 1
    remainder RESB 1

section .text
    global _start

_start:
    ; Print "The Dividing Program"
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, dividingTitle
    mov edx, dividingTitleLen
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

    ; Divide the two numbers
    xor al, al
    xor ah, ah
    mov al, [num1]
    sub al, '0'
    mov bl, [num2]
    sub bl, '0'
    idiv bl
    add al, '0'
    add ah, '0'
    mov [quotient], al
    mov [remainder], ah

    ; Print the quotient prompt
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, quotientMsg
    mov edx, lenQuotientMsg
    int 0x80

    ; Print the quotient
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, quotient
    mov edx, 1
    int 0x80

    ; Print New Line
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, newLine
    mov edx, newLineLen
    int 0x80

    ; Print the remainder prompt
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, remainderMsg
    mov edx, lenRemainderMsg
    int 0x80

    ; Print the remainder
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, remainder
    mov edx, 1
    int 0x80

    ; Print New Line
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, newLine
    mov edx, newLineLen
    int 0x80

    mov eax, SYS_EXIT
    int 0x80
