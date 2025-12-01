BITS 32
SECTION .text
    GLOBAL factstr
    GLOBAL addstr
    EXTERN atoi
    EXTERN fact

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

