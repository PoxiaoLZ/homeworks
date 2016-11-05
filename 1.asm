data    segment
; buff    dw 1,0,-1,-1,1    ;调试用数据
buff    dw 200 dup(?)
save    db 3 dup(?)
data    ends

code    segment
        assume cs: code, ds: data
start:  mov ax, data
        mov ds, ax
        xor bx, bx
        xor dx, dx
        ; mov cx, 5
        mov cx, 200
        lea si, buff
        sub si, 2
next1:  add si, 2
        cmp word ptr[si],0
        jnz nz
        inc bx
        jmp ok
nz:     test [si], 8000h
        jnz n
        inc dh
        jmp ok
n:      inc dl
ok:     loop next1
        mov save, dh
        mov save+1, dl
        mov save+2, bl
        ; mov al, dh        ;调试输出用
        ; mov dl, bl
        ; add dl, 30h
        ; mov ah, 2
        ; int 21h
        mov ah, 4ch
        int 21h

code ends
        end start
