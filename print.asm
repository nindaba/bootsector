print:
    pusha

start:
    mov al, [bx]
    cmp al,0
    je endp
    mov ah,0x0e
    int 0x10
    add bx,1
    jmp start

startl:
    mov al, [bx]
    cmp al,0
    je endl
    mov ah,0x0e
    int 0x10
    add bx,1
    jmp startl

endp:
    popa
    ret

printl:
    pusha 
    jmp startl

endl:
    mov ah,0x0e
    mov al,0x0a
    int 0x10
    mov al,0x0d
    int 0x10
    jmp endp


printh:
    pusha
    mov cx,0

convert_last_dx_block:
    cmp cx,4
    je endh

    mov ax,dx
    and ax,0x000f
    add al,0x30
    cmp al,0x39
    jle add_to_string
    add al,7

add_to_string:
    mov bx, HEX_STRING+5
    sub bx, cx
    mov [bx], al
    ror dx,4
    add cx,1
    jmp convert_last_dx_block

endh:
    mov bx, HEX_STRING
    call print
    popa
    ret

HEX_STRING:
    db '0x0000',0