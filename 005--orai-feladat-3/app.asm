
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
    push 24                 ; [o_min, s_min, o_max, s_max]
        
    pop ax                  ; 1. sorban kezdunk
    mov ah, 1
    push ax                 ; [..., s_current-s_max]
    
    xor ah, ah              ; ido baseline
    int 1ah
    add dx, 4
    push dx                 ; [..., s_current-s_max, ido]
    
Rajzol_lefele:    

    xor ah, ah              ; kesleltetes
    int 1ah
    pop cx
    push cx                 ; [..., s_current-s_max, ido]
    cmp dx, cx
    jl Rajzol_lefele 
    pop cx                  ; [..., s_current-s_max]
    
    mov bh, 0               ; kurzor
    pop dx
    push dx                 ; [..., s_current-s_max]
    mov dl, 1
    mov ah, 2
    int 10h
    
    mov dx, offset karakter ; karakter kiiras
    mov ah, 09h
    int 21h
    
    pop bx                  ; [..., s_current-s_max]
    inc bh                  ; inkrementalas
    push bx                 ; [..., s_current-s_max]

    xor ah, ah              ; ido baseline
    int 1ah
    add dx, 4
    push dx                 ; [..., s_current-s_max, ido]    

    cmp bl, bh
    jnz Rajzol_lefele
    pop ax                  ; [..., s_min, o_max, s_current-s_max]
    pop ax                  ; [..., s_min, o_max]
    pop ax                  ; [..., s_min]
    mov ah, al              
    mov al, 1               ;
    push ax                 ; [..., s_min, o_max-o_current]    
    
    xor ah, ah              ; ido baseline
    int 1ah
    add dx, 4
    push dx                 ; [..., o_max-o_current, ido]

Rajzol_jobbra:
    xor ah, ah              ; kesleltetes
    int 1ah
    pop cx
    push cx                 ; [..., o_max-o_current, ido]
    cmp dx, cx
    jl Rajzol_jobbra 
    pop cx  

    pop dx                  ; kurzor
    push dx    
    mov dh, 23
    mov bh, 0               
    mov ah, 2
    int 10h
    
    mov dx, offset karakter ; karakter kiiras 
    mov ah, 09h
    int 21h
    
    pop bx                  ; [..., o_max-o_current]
    inc bl                  ; inkrementalas
    push bx                 ; [..., o_max-o_current]
   
    xor ah, ah              ; ido baseline
    int 1ah
    add dx, 4
    push dx                 ; [..., o_max-o_current, ido]
    
    cmp bl, bh
    jnz Rajzol_jobbra
    pop ax                  ; [o_min, s_min, o_max-o_current]
    pop ax                  ; [o_min, s_min]
    pop ax                  ; [o_min]
    mov ah, 23
    push ax                 ; [o_min, s_current-s_min]
         
    xor ah, ah              ; ido baseline
    int 1ah
    add dx, 4
    push dx                 ; [..., s_current-s_min, ido]

Rajzol_felfele:    
    xor ah, ah              ; kesleltetes
    int 1ah
    pop cx
    push cx                 ; [..., s_current-s_min, ido]
    cmp dx, cx
    jl Rajzol_felfele 
    pop cx                  ; [..., s_current-s_min]
 
    pop dx                  ; kurzor
    push dx    
    mov dl, 78
    mov bh, 0               
    mov ah, 2
    int 10h
    
    mov dx, offset karakter ; karakter kiiras 
    mov ah, 09h
    int 21h
    
    pop bx                  ; [..., s_current-s_min]
    dec bh                  ; dekrementalas
    push bx                 ; [..., s_current-s_min]

    xor ah, ah              ; ido baseline
    int 1ah
    add dx, 4               
    push dx                 ; [..., s_current-s_min, ido]
    
    cmp bl, bh
    jnz Rajzol_felfele
    pop ax                  ; [o_min s_current-s_min]
    pop ax                  ; [o_min]
    pop ax                  ; []
    mov ah, al               
    mov al, 78               
    push ax                 ; [o_min-o_current]
    
    xor ah, ah              ; ido baseline
    int 1ah
    add dx, 4               
    push dx                 ; [o_min-o_current, ido]
         
Rajzol_balra:    
    xor ah, ah              ; kesleltetes
    int 1ah
    pop cx
    push cx                 ; [o_min-o_current, ido]
    cmp dx, cx
    jl Rajzol_balra 
    pop cx                  ; [o_min-o_current]

    pop dx                  ; kurzor
    push dx    
    mov dh, 1
    mov bh, 0               
    mov ah, 2
    int 10h
    
    mov dx, offset karakter ; karakter kiiras 
    mov ah, 09h
    int 21h
 
    pop bx                  ; [o_min-o_current]
    dec bl                  ; dekrementalas
    push bx                 ; [o_min-o_current]

    xor ah, ah              ; ido baseline
    int 1ah
    add dx, 4        
    push dx                 ; [o_min-o_current, ido]

    cmp bl, bh
    jnz Rajzol_balra

    xor ax, ax              ; bevitel
    int 16h

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