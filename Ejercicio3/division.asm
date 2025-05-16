section .data
    msg1 db 'Ingrese dividendo: ',0
    len1 equ $-msg1
    msg2 db 'Ingrese divisor: ',0
    len2 equ $-msg2
    quotient_msg db 'Cociente: ',0
    len_q equ $-quotient_msg
    remainder_msg db 'Resto: ',0
    len_r equ $-remainder_msg
    newline db 10

section .bss
    dividend resd 1
    divisor resd 1
    buffer resb 12
    num_buffer resb 12

section .text
    global _start

_start:
    ; Solicitar dividendo
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 0x80

    ; Leer dividendo
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 12
    int 0x80
    call atoi32
    mov [dividend], eax

    ; Solicitar divisor
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 0x80

    ; Leer divisor
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 12
    int 0x80
    call atoi32
    mov [divisor], eax

    ; Realizar división
    mov eax, [dividend]
    xor edx, edx
    mov ebx, [divisor]
    div ebx

    ; Guardar resultados
    mov [dividend], eax  ; Cociente
    mov [divisor], edx   ; Resto

    ; Mostrar cociente
    mov eax, 4
    mov ebx, 1
    mov ecx, quotient_msg
    mov edx, len_q
    int 0x80

    mov eax, [dividend]
    call print_number

    ; Nueva línea
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Mostrar resto
    mov eax, 4
    mov ebx, 1
    mov ecx, remainder_msg
    mov edx, len_r
    int 0x80

    mov eax, [divisor]
    call print_number

    ; Nueva línea final
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Salir
    mov eax, 1
    mov ebx, 0
    int 0x80

; Función para convertir string a número (EAX)
atoi32:
    xor eax, eax
    mov esi, buffer
.next_digit:
    movzx ebx, byte [esi]
    inc esi
    cmp bl, 10          ; Fin de línea
    je .done
    sub bl, '0'
    imul eax, 10
    add eax, ebx
    jmp .next_digit
.done:
    ret

; Función para imprimir número (EAX = número)
print_number:
    mov edi, num_buffer + 11  ; Apuntar al final del buffer
    mov byte [edi], 0         ; Null-terminator
    dec edi

    mov ebx, 10
    mov ecx, 1                ; Contador de dígitos (mínimo 1)

    ; Caso especial para 0
    test eax, eax
    jnz .convert_loop
    mov byte [edi], '0'
    jmp .print

.convert_loop:
    xor edx, edx
    div ebx
    add dl, '0'
    mov [edi], dl
    dec edi
    inc ecx
    test eax, eax
    jnz .convert_loop

    ; Ajustar puntero al primer dígito
    inc edi

.print:
    ; Imprimir el número
    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    mov edx, ecx        ; Usar el contador de dígitos como longitud
    int 0x80
    ret