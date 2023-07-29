disk_load:
    pusha
    push dx
    mov ah, 0x02    ;read disk mode
    mov al, dh      ;number of sectors to read
    mov cl, 0x01    ;sector to start reading 
    mov ch, 0x00    ;cylinder to read
    mov dh, 0x00    ;head to use
    int 0x13        ;reading interrupt

    jc disk_error

    pop dx
    cmp al, dh   ;BIOS also sets 'al' to the # of sectors read. Compare it.
    jne sectors_error
    popa
    ret

disk_error:
    mov bx, DISK_ERROR
    call printl
    mov dh, ah      ;store the error code
    call printh
    jmp disk_loop

sectors_error:
    mov bx, SECTORS_ERROR
    call printl
    jmp disk_loop

disk_loop:
    jmp $


DISK_ERROR: db "Disk read error", 0
SECTORS_ERROR: db "Incorrect number of sector read", 0