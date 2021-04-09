
Code    Segment
        assume CS:Code, DS:Data, SS:Stack

Start:
    mov ax, Code
    mov ds, ax
    mov ax, 03
    int 10h
    
    push 1
    push 1
    push 78
    push 23
    
    
    mov dh, 1
    pop cx                  ; max

Rajzol_lefele:    
    mov bh, 0               ; kurzor
    mov dl, 1
    mov ah, 2
    int 10h
    
    push dx                 ; karakter kiiras    
    mov dx, offset karakter 
    mov ah, 09h
    int 21h
    pop dx
    
    xor ax, ax              ; bevitel
    int 16h
    
    inc dh                  ; inkrementalas
    cmp cl, dh
    jnz Rajzol_lefele
    pop cx
    
Rajzol_jobbra:    
    mov bl, 0               ; kurzor
    mov ah, 2
    int 10h
    
    push dx                 ; karakter kiiras
    mov dx, offset karakter 
    mov ah, 09h
    int 21h
    pop dx
    
    xor ax, ax              ; bevitel
    int 16h
    
    inc dl                  ; inkrementalas
    cmp cl, dl
    jnz Rajzol_jobbra
    pop cx
    
Rajzol_felfele:    
    mov bl, 0               ; kurzor
    mov ah, 2
    int 10h
    
    push dx                 ; karakter kiiras
    mov dx, offset karakter 
    mov ah, 09h
    int 21h
    pop dx
    
    xor ax, ax              ; bevitel
    int 16h
    
    dec dh                  ; dekrementalas
    cmp cl, dh
    jnz Rajzol_felfele
    pop cx
    
Rajzol_balra:    
    mov bl, 0               ; kurzor
    mov ah, 2
    int 10h
    
    push dx                 ; karakter kiiras
    mov dx, offset karakter 
    mov ah, 09h
    int 21h
    pop dx
    
    xor ax, ax              ; bevitel
    int 16h
    
    dec dl                  ; dekrementalas
    cmp cl, dl
    jnz Rajzol_balra

Program_vege:
    mov ax, 3
    int 10h

    mov ax, 4c00h
    int 21h

karakter: db 'X$'


Code    Ends
Data    Segment
Data    Ends
Stack   Segment
Stack   Ends
End     Start