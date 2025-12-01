BITS 32
SECTION .data
    pal_prompt DB "Enter a string: "
    pal_prompt_len EQU $ - pal_prompt

SECTION .bss
    buffer RESB 128

SECTION .text
    GLOBAL factstr
    GLOBAL addstr
    GLOBAL is_palindromeASM
    GLOBAL palindrome_check
    EXTERN atoi
    EXTERN fact
    EXTERN is_palindromeC

; Option 1: Add two numbers together
addstr:
    push ebp
    mov ebp, esp
    
    ; A
    push DWORD [ebp+8]
    call atoi
    add esp, 4
    
    push eax

    ; B
    push DWORD [ebp+12]
    call atoi
    add esp, 4

    pop ecx
    add eax, ecx

    mov esp, ebp
    pop ebp
    ret
; Option 2: Palindrome (C -> ASM)
is_palindromeASM:
    push ebp
    mov ebp, esp
    push esi
    push ebx

    mov esi, [ebp+8]    ; String input

    xor ecx, ecx        ; length = 0
.len_loop:
    cmp byte [esi + ecx], 0 ; check for null terminator
    je .len_done
    inc ecx
    jmp .len_loop
.len_done:
    ; ecx contains length

    cmp ecx, 0
    je .is_pal          ; empty string is palindrome

    mov ebx, ecx        ; j = length
    dec ebx             ; j = length - 1
    shr ecx, 1          ; limit = length / 2
    xor eax, eax        ; i = 0

.again:
    cmp eax, ecx
    jge .is_pal     ; if i >= len/2, done
    mov dl, [esi + eax] ; buf[i]
    mov dh, [esi + ebx] ; buf[j]
    cmp dl, dh
    jne .not_pal
    inc eax
    dec ebx
    jmp .again

.is_pal:
    mov eax, 1
    jmp .done

.not_pal:
    xor eax, eax

.done:
    pop ebx
    pop esi
    mov esp, ebp
    pop ebp
    ret

; Option 3: Print the factorial of a number
factstr:
    push ebp
    mov ebp, esp
    
    push DWORD [ebp+8]
    call atoi
    add esp, 4

    push eax
    call fact
    add esp, 4

    mov esp, ebp
    pop ebp
    ret

; Option 4: Test if a string is a palindrome (ASM -> C)
palindrome_check:
    push ebp
    mov ebp, esp

    ; Prints: "Enter a string: "
    mov eax, 4
    mov ebx, 1
    mov ecx, pal_prompt
    mov edx, pal_prompt_len
    int 0x80

    ; Receives string from user
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 128
    int 0x80
    
    push [edx]
    push [ecx]
    call is_palindromeC
    
    add esp, 8
    mov esp, ebp
    pop ebp
