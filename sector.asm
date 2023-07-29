;##########
;CHAPTER 1
;
;   The sector is 512 bytes where the last two bytes represent
; the boot number to look for and it standard 0xaa55
;
;##########
; ;Infinite loop
; loop:
;     jmp loop
; ;Fill with 510 zeros minus the size of the previous code
; times 510-($-$$) db 0
; ; Magic Number
; dw 0xaa55
;
;##########
;CHAPTER 2
;
; Hello on the screen example,
; 0x10 is the interrupt for the video service
;##########

; mov ah, 0x0e ;tty mode
; mov al, 'H'
; int 0x10
; mov al, 'E'
; int 0x10
; mov al, 'L'
; int 0x10
; mov al, 'L'
; int 0x10
; mov al, 'O'
; int 0x10

; jmp $

; times 510-($-$$) db 0
; dw 0xaa55

;#########
;CHAPTER 3
;Addressing, offset and pointers
;#########
; [org 0x7c00]
; the_secret:
;     db 'X'

; mov ah,0x0e
; mov al, [0x7C00]
; int 0x10
; mov bx, the_secret
; ; add bx, 0x7C00 ;This offset adding can be replaced by [org 0x7C00] in the header
; mov al, [bx]
; int 0x10

; jmp $
; times 510-($-$$) db 0
; dw 0xaa55

;#########
;CHAPTER 4
;Stack and Heap
;#########
; [org 0x7c00]
; mov ah,0x0e

; mov bp,0x8000
; mov sp, bp

; push 'A'
; push 'R' 
; push 'T' 
; push 'H' 
; push 'U' 
; push 'R'

; pop bx,
; mov al, bl
; int 0x10
; pop bx,
; mov al, bl
; int 0x10
; pop bx,
; mov al, bl
; int 0x10
; pop bx,
; mov al, bl
; int 0x10
; pop bx,
; mov al, bl
; int 0x10
; pop bx,
; mov al, bl
; int 0x10

; mov al,[0x8000]
; int 0x10

; times 510-($-$$) db 0
; dw 0xaa55


;#########
;CHAPTER 5
;control structures, function calling and strings
;#########

[org 0x7c00]

; cmp ax, 4
; je ax_is_four
; jmp else

; mov bx, save_hello
; call printl
; mov bx, NEW_LINE
; call print
; mov dx, 0x143a
; call printh
; jmp $

; %include "print.asm"

; save_hello:
;     db "Hello ASM, how do I do", 0
; NEW_LINE:
;     db "Now you know why we must jump to start, we can skip things we dont want to do right"
; HEX_IN:
;     dw 0x143a

; times 510-($-$$) db 0
; dw 0xaa55


;##########
; CHAPTER 6
; Segmentation in 16-beat
;##########

; [org 0x7c00]

; mov ah,0x0e

; mov al,[es:the_secret]
; int 0x10

; the_secret:
;     db 'xx2',0


; times 510-($-$$) db 0
; dw 0xaa55

;##########
; CHAPTER 7
; Bootsector load data from disk
;##########

[org 0x7c00]

mov bp, 0x8000
mov sp,bp

mov bx, 0x9000  ;this will make segmentation es:bx 0x0000:0x9000 = 0x9000
mov dh, 0x1       ;read sector 2
call disk_load

; call printh
mov bx, FIRST_SECTOR
call printl

mov dx, [0x9000]
call printh

mov bx, EMPTY_CHAR
call printl
mov bx, SECOND_SECTOR
call printl

mov dx, [0x9000 + 512]
call printh

jmp $

%include "print.asm"
%include "disk.asm"

FIRST_SECTOR: db "First Sector",0
SECOND_SECTOR: db "Second Sector",0
EMPTY_CHAR: db "",0

times 510-($-$$) db 0
dw 0xaa55

times 256 dw 0xaaaa
times 256 dw 0xffff