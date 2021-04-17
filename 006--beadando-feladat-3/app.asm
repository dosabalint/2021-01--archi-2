
Code    Segment
        assume CS:Code, DS:Data, SS:Stack

Start:
    mov ax, Code
    mov ds, ax
    mov ax, 03
    int 10h
    push -1
      
Udvozlo_szoveg:
    mov dh, 1                   ; kurzor
    mov dl, 2
    mov bh, 0               
    mov ah, 2
    int 10h
    
    mov dx, offset szoveg1      ; udvozlo szoveg kiiras
    mov ah, 09h
    int 21h 

    mov dh, 2                   ; kurzor
    mov dl, 2
    mov bh, 0               
    mov ah, 2
    int 10h
    
    mov dx, offset szoveg2      ; udvozlo szoveg kiiras
    mov ah, 09h
    int 21h 

    xor ax, ax                  ; bevitel
    int 16h

    push 0                      ; [szamlalo]    
    
    xor ah, ah                  ; ido baseline
    int 1ah
    add dx, 10
    push dx                     ; [szamlalo, ido]

    mov ax, 3                   ; clear screen
    int 10h
    
Reflex_loop:
    xor ah, ah                  ; kesleltetes
    int 1ah
    pop cx
    push cx                     ; [szamlalo, ido]
    cmp dx, cx
    jl Reflex_loop 
    
    mov dh, 2                   ; kurzor
    mov dl, 2
    mov bh, 0               
    mov ah, 2
    int 10h
 
    mov dx, offset szoveg3      ; gombnyomos szoveg
    mov ah, 09h
    int 21h
     
    xor ax, ax                  ; bevitel
    int 16h
    
    xor ah, ah                  ; eredmeny rogzites
    int 1ah
    pop cx                      ; [szamlalo]
    pop bx                      ; []
    inc bx
    mov ax, dx
    sub ax, cx
    push ax                     ; [eredmeny, szamlalo]
    push bx
    
    add dx, 10
    push dx                     ; [eredmeny, szamlalo, ido]

    mov ax, 3                   ; clear screen
    int 10h
     
    
    pop dx
    pop bx
    push bx
    push dx
    cmp bx, 9
    jnz Reflex_loop 
    
    pop dx                      ; [eredmeny, eredmeny, ..., szamlalo]
    xor ax, ax
    
Kiertekeles:
    pop dx
    add ax, dx
    
    cmp dx, -1
    jnz Kiertekeles

    push ax
    
    xor ah, ah                  ; clear screen
    int 10h
    
    mov dh, 1                   ; kurzor
    mov dl, 2
    mov bh, 0               
    mov ah, 2
    int 10h
    
    pop ax
    
Kiir_0:
    mov dx, offset eredmeny0
    cmp ax, 20
    jng Program_vege      
    
Kiir_1:
    mov dx, offset eredmeny1
    cmp ax, 40
    jng Program_vege     

Kiir_2:
    mov dx, offset eredmeny2
    cmp ax, 60
    jng Program_vege     

Kiir_3:    
    mov dx, offset eredmeny3
    cmp ax, 80
    jng Program_vege     

Kiir_4:    
    mov dx, offset eredmeny4
    cmp ax, 100
    jng Program_vege     

Kiir_5:    
    mov dx, offset eredmeny5
    cmp ax, 120
    jng Program_vege     

Kiir_6:    
    mov dx, offset eredmeny6
    cmp ax, 140
    jng Program_vege     

Kiir_7:    
    mov dx, offset eredmeny7
    cmp ax, 160
    jng Program_vege     

Kiir_8:    
    mov dx, offset eredmeny8
    cmp ax, 180
    jng Program_vege     

Kiir_9:
    mov dx, offset eredmeny9
    cmp ax, 200
    jng Program_vege     

Kiir_tul_lassu:        
    mov dx, offset eredmeny_tul_lassu
    
Program_vege:
    mov ah, 09h
    int 21h 

    xor ax, ax                  ; bevitel
    int 16h

    mov ax, 3                   ; clear screen
    int 10h

    mov ax, 4c00h
    int 21h

szoveg1: db 'Gombokat kell majd lenyomnod.$'
szoveg2: db 'Minel gyorsabban nyomod le a gombot, ann?l jobb pontszamot kapsz majd.$'
szoveg3: db 'Nyomj le egy gombot.$'

eredmeny0: db 'Eredmeny: 0$'
eredmeny1: db 'Eredmeny: 1$'
eredmeny2: db 'Eredmeny: 2$'
eredmeny3: db 'Eredmeny: 3$'
eredmeny4: db 'Eredmeny: 4$'
eredmeny5: db 'Eredmeny: 5$'
eredmeny6: db 'Eredmeny: 6$'
eredmeny7: db 'Eredmeny: 7$'
eredmeny8: db 'Eredmeny: 8$'
eredmeny9: db 'Eredmeny: 9$'
eredmeny_tul_lassu: db 'Eredmeny: tul lassu$'

Code    Ends
Data    Segment
Data    Ends
Stack   Segment
Stack   Ends
End     Start