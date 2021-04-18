Code    Segment
        assume CS:Code, DS:Data, SS:Stack

Start:
    mov di, 82h
    mov cx, 10
    ; jmp Default_hiba
    
Keres:
    mov dl, [di]
    cmp dl, "/"
    jz ParamKezdet_elso
    inc di
    loop Keres
    jmp Default

ParamKezdet_elso:
    inc di
    mov bl, [di]
    
    cmp bl, 63                  ; ?
    jz Help
    
    cmp bl, 48                  
    jl  Default_hiba            ; kisebb mint 0

    cmp bl, 57                  
    jg  Default_hiba            ; nagyobb mint 9
    sub bl, 48
    
ParamKezdet_masodik:
    inc di
    mov bh, [di]

    cmp bh, 48
    jl Nincs_masodik

    cmp bh, 57
    jg Nincs_masodik
    
    sub bh, 48
    mov ax, 10
    mul bl
    
    add al, bh
    mov cx, ax
    jmp Init
    
Nincs_masodik:
    mov ax, Code
    mov ds, ax

    mov bh, 0
    mov cx, bx
    jmp Init

Help:
    mov ax, Code
    mov ds, ax

    mov ax, 3                   ; clear screen
    int 10h
    
    mov dh, 0                   ; kurzor
    mov dl, 0
    mov bh, 0               
    mov ah, 02h
    int 10h
 
    mov dx, offset helpszoveg      ; gombnyomos szoveg
    mov ah, 09h
    int 21h

    jmp Var    
    
Default_hiba:
    mov ax, Code
    mov ds, ax
    
    mov ax, 3                   ; clear screen
    int 10h

    mov dh, 0                   ; kurzor
    mov dl, 0
    mov bh, 0               
    mov ah, 02h
    int 10h
    
    mov dx, offset hibaszoveg      ; hiba szoveg
    mov ah, 09h
    int 21h 
    
    xor ax, ax
    int 16h    
    
    mov ax, 3                   ; clear screen
    int 10h
    
Default:
    mov cx, 10          ; alapertelmezett v0

Init:
    mov ax, Code
    mov ds, ax

    xor di, di              ; golyo sor pozicioja
    xor si, si              ; golyo oszlop pozicioja
    
    xor dx, dx
    push dx                 ; [ido = 0]

Torles:
    mov ax, 03h
    int 10h

Rajz:
    mov bx, di              ; kurzor
    mov dh, bl
    mov bx, si
    mov dl, bl
    xor bh, bh
    mov ah, 02h
    int 10h
    
    mov dx, offset labda    ; labda kirajzolas
    mov ah, 09h
    int 21h

    pop ax                  ; sy kiszamitas
    push ax
    mov bl, al
    mul bl
    shr ax, 1
    mov di, ax

    pop ax                  ; sx kiszamitas
    inc ax
    push ax
    dec ax
    mov bl, cl
    mul bl
    mov si, ax

    cmp si, 80              ; jobb szele?
    jnc Var

    cmp di, 25              ; also szele?
    jnc Var
    jmp Rajz

Var:
    xor ax, ax
    int 16h

Program_Vege:
    pop cx
    mov ax, 4c00h
    int 21h

labda: db "O$"
helpszoveg: db "A megadott ertek lesz a kezdo sebesseg.$"
hibaszoveg: db "Hibas kezdeti ertek, defaulttal megyunk tovabb.$"
nincs_masodik_szoveg: db "Nincs masodik szoveg.$"

Code    Ends

Data    Segment
Data    Ends

Stack   Segment
Stack   Ends
        End Start