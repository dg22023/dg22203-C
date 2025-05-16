section .data
    msg1 db 'Ingrese primer numero : ',0
    msg2 db 'Ingrese segundo numero : ',0
    msg3 db 'Ingrese tercer numero : ',0
    result_msg db 'Resultado : ',0
    newline db 10,0

section .bss
    num1 resw 1
    num2 resw 1
    num3 resw 1
    buffer resb 5

section .text
    global _start

_start:
    ; Solicitar y leer primer número
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, 20
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 5
    int 0x80
    call atoi
    mov [num1], ax

    ; Solicitar y leer segundo número
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, 21
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 5
    int 0x80
    call atoi
    mov [num2], ax

    ; Solicitar y leer tercer número
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, 21
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 5
    int 0x80
    call atoi
    mov [num3], ax

    ; Realizar resta
    mov ax, [num1]
    sub ax, [num2]
    sub ax, [num3]

    ; Mostrar resultado
    mov [num1], ax
    mov eax, 4
    mov ebx, 1
    mov ecx, result_msg
    mov edx, 11
    int 0x80

    call itoa
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, 5
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Salir
    mov eax, 1
    mov ebx, 0
    int 0x80

atoi:
    xor eax, eax
    xor ebx, ebx
    mov esi, buffer
.convert:
    mov bl, [esi]
    cmp bl, 10
    je .done
    sub bl, '0'
    imul eax, 10
    add eax, ebx
    inc esi
    jmp .convert
.done:
    ret

itoa:
    mov edi, buffer
    add edi, 4
    mov byte [edi], 0
    mov ax, [num1]
    mov bx, 10
.convert_loop:
    dec edi
    xor dx, dx
    div bx
    add dl, '0'
    mov [edi], dl
    test ax, ax
    jnz .convert_loop
    ret
