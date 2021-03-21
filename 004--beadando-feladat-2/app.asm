
Code    Segment
        assume CS:Code, DS:Data, SS:Stack

Start:
    mov ax, Code
    mov ds, ax
    mov ax, 03
    int 10h

MenuKiiras:
    mov ah, 2
    mov bh, 0
    mov dh, 1
    mov dl, 0
    int 10h

    mov dx, offset ertek1_prefix
    mov ah, 09
    int 21h

    mov dx, offset ertek1
    mov ah, 09
    int 21h

    mov ah, 2
    mov bh, 0
    mov dh, 2
    mov dl, 0
    int 10h

    mov dx, offset ertek2_prefix
    mov ah, 09
    int 21h

    mov dx, offset ertek2
    mov ah, 09
    int 21h

    mov ah, 2
    mov bh, 0
    mov dh, 4
    mov dl, 2
    int 10h

    mov dx, offset menuszoveg1
    mov ah, 9
    int 21h

    mov ah, 2
    mov bh, 0
    mov dh, 5
    mov dl, 2
    int 10h

    mov dx, offset menuszoveg2
    mov ah, 9
    int 21h

    mov ah, 2
    mov bh, 0
    mov dh, 6
    mov dl, 2
    int 10h

    mov dx, offset menuszoveg3
    mov ah, 9
    int 21h

    mov ah, 2
    mov bh, 0
    mov dh, 7
    mov dl, 2
    int 10h

    mov dx, offset menuszoveg4
    mov ah, 09
    int 21h

    xor ax, ax
    int 16h

    cmp al, 27
    jz JI_Program_vege

    cmp al, '1'
    jz Bevitel1

    cmp al, '2'
    jz Bevitel2

    jmp MenuKiiras

Bevitel1: 
    mov bx, offset ertekvalaszto
    mov al, '1'
    mov [bx], al
    mov di, offset ertek1
    
    mov ah, 2
    mov bh, 0
    mov dh, 1
    mov dl, 0
    int 10h
    mov dx, offset marker
    mov ah, 09
    int 21h
    mov ah, 2
    mov dh, 1
    mov dl, 11
    int 10h
    
    jmp Bevitel

Bevitel2: 
    mov bx, offset ertekvalaszto
    mov al, '2'
    mov [bx], al
    mov di, offset ertek2
    
    mov ah, 2
    mov bh, 0
    mov dh, 2
    mov dl, 0
    int 10h
    mov dx, offset marker
    mov ah, 09
    int 21h
    mov ah, 2
    mov dh, 2
    mov dl, 11
    int 10h
    
    jmp Bevitel

JI_Program_vege:
    jmp Program_vege

Bevitel:
    xor ax, ax
    int 16h
    cmp al, 27
    jz JI_Program_vege

    mov cx, dx
    mov ah, 2
    mov bh, 0
    mov dh, 10
    mov dl, 2
    int 10h
    mov dx, offset spacer
    mov ah, 09
    int 21h
    
    mov dx, cx
    mov cx, 10
    mov ah, '0' 

Vizsgal:
    cmp ah, al
    jz Tarol
    inc ah
    loop Vizsgal
    
    mov cx, dx
    
    mov ah, 2
    mov bh, 0
    mov dh, 10
    mov dl, 2
    int 10h

    mov dx, offset hiba
    mov ah, 09
    int 21h
    
    mov dx, cx
    
    jmp Bevitel

JI_Bevitel:
    jmp Bevitel
    
Tarol:
    mov [di], al
    inc di
    mov al, '$' 
    mov [di], al

    mov ah, 2
    mov bh, 0
    ; mov dh, 1
    mov dl, 11
    int 10h

    mov bx, offset ertekvalaszto
    mov al, '1'
    cmp [bx], al
    jz Tarol1
    mov al, '2'
    cmp [bx], al
    jz Tarol2

    jmp Program_Vege

Tarol1:
    mov cx, dx
    mov dx, offset ertek1
    mov ah, 09
    int 21h
    mov dx, cx
    
    mov ax, offset ertek1
    add ax, 4
    cmp ax, di
    jnz Bevitel
    
    jmp MenuKiiras
    
Tarol2:
    mov cx, dx
    mov dx, offset ertek2
    mov ah, 09
    int 21h
    mov dx, cx
    
    mov ax, offset ertek2
    add ax, 4
    cmp ax, di
    jnz JI_Bevitel
    
    jmp MenuKiiras

Program_vege:
    mov ax, 3
    int 10h

    mov ax, 4c00h
    int 21h

hiba: db 'Nem megengedett karakter!$'
ertek1: db '****$' 
ertek2: db '****$' 
ertek1_prefix: db '  ertek 1: $' 
ertek2_prefix: db '  ertek 2: $' 
ertekvalaszto: db '0$'
menuszoveg1: db 'Menu:$' 
menuszoveg2: db ' - 1: ertek1 felvetele$' 
menuszoveg3: db ' - 2: ertek2 felvetele$' 
menuszoveg4: db ' - esc: kilepes$' 

spacer: db '                             $'
marker: db '*$'

Code    Ends
Data    Segment
Data    Ends
Stack   Segment
Stack   Ends
End     Start