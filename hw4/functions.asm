BITS 32
SECTION .text
    GLOBAL factstr
    EXTERN atoi
    EXTERN fact

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

