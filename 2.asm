data    segment
string  db 'abcdefg',00h
found   db ?
pos     db ?
data    ends

extra   segment
subst   db 'cdae',00h
extra   ends

code    segment
        assume cs: code, ds: data, es: extra
start:  xor ax,ax
        mov ax, data
        mov ds, ax
        mov ax, extra
        mov es, ax
        lea si, string
        lea di, subst       ;初始化
        mov dx, di          ;保存子串起始位置
        mov bx, si          ;保存原串已匹配的位置
        jmp lp0
        
lp0:    cmp es:[di],  byte ptr 00h
        jz lp3
        cmp ds:[si], byte ptr 00h
        jz lp4
        jmp lp1
        
lp1:    cmpsb
        jnz lp2
        jmp lp0
        
lp2:    inc bx              ;匹配失败
        mov si, bx
        mov di, dx
        jmp lp0

lp3:    mov found, 0ffh
        mov byte ptr pos, bl
        
        ; mov dx, bx        ;输出效果
        ; add dl, 30h
        ; mov ah, 2
        ; int 21h
        ;mov cl, [found]
        mov ah, 4ch
        int 21h
        
lp4:    mov found, 00h
        ;mov cl, [found]
        mov ah, 4ch
        int 21h
code ends
        end start