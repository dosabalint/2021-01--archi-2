
Code 	Segment
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
	mov dl, 2
	int 10h

	mov dx, offset menuszoveg1
	mov ah, 9
	int 21h

	mov ah, 2
	mov bh, 0
	mov dh, 2
	mov dl, 2
	int 10h

	mov dx, offset menuszoveg2
	mov ah, 9
	int 21h

	mov dx, offset ertek1
	mov ah, 9
	int 21h

	mov dx, offset menuszovegerteksorveg
	mov ah, 9
	int 21h

	mov ah, 2
	mov bh, 0
	mov dh, 3
	mov dl, 2
	int 10h

	mov dx, offset menuszoveg3
	mov ah, 9
	int 21h

	mov dx, offset ertek2
	mov ah, 9
	int 21h

	mov dx, offset menuszovegerteksorveg
	mov ah, 9
	int 21h

	mov ah, 2
	mov bh, 0
	mov dh, 4
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

	; cmp al, '2'
	; jz Bevitel2

	jmp MenuKiiras

Bevitel1: 
	mov bx, offset ertekvalaszto
	mov al, '1'
	mov [bx], al
	mov di, offset ertek1
	jmp Bevitel

; Bevitel2: 
; 	mov bx, offset ertekvalaszto
; 	mov al, '2'
; 	mov [bx], al
; 	mov di, offset ertek2
; 	jmp Bevitel

Bevitel:
	xor ax, ax
	int 16h

	mov bx, ax
	mov ax, 03
	int 10h

	mov ax, bx
	cmp al, 27
	jz JI_Program_vege

	mov cx, 10
	mov ah, '0' 

Vizsgal:
	cmp ah, al
	jz Tarol
	inc ah
	loop Vizsgal

	mov ah, 2
	mov bh, 0
	mov dh, 1
	mov dl, 2
	int 10h

	mov dx, offset hiba
	mov ah, 09
	int 21h

	jmp Bevitel

JI_Program_vege:
	jmp Program_vege

JI_Bevitel:
	jmp Bevitel

Tarol:
	mov [di], al
	inc di
	mov al, '$' 
	mov [di], al

	mov ah, 2
	mov bh, 0
	mov dh, 1
	mov dl, 2
	int 10h

	; mov bx, offset ertekvalaszto
	; mov ah, [bx]

	; cmp ah, '1'
	; jnz Tarol1

	; cmp ah, '2'
	; jnz Tarol2

	; jmp Program_vege

Tarol1:
	mov dx, offset ertek1
	mov ah, 09
	int 21h
	
	mov ax, offset ertek1
	add ax, 4
	cmp ax, di
	jnz Bevitel1
	
	; jmp TarolVege

; Tarol2:
; 	mov dx, offset ertek2
; 	mov ah, 09
; 	int 21h
	
; 	mov ax, offset ertek2
; 	add ax, 4
; 	cmp ax, di
; 	jnz JI_Bevitel
	
; 	jmp TarolVege

TarolVege:
	mov ah, 2
	mov bh, 0
	mov dh, 1
	mov dl, 2
	int 10h

	mov dx, offset uzenet
	mov ah, 09
	int 21h

Program_vege:
	mov ax, 4c00h
	int 21h

hiba: db 'Nem megengedett karakter!$'
ertek1: db '****$' 
ertek2: db '****$' 
ertekvalaszto: db '0$'
uzenet: db 'Vege a bevitelnek$' 
menuszoveg1: db 'Menu:$' 
menuszoveg2: db ' - 1: ertek1 felvetele ($' 
menuszoveg3: db ' - 2: ertek2 felvetele ($' 
menuszoveg4: db ' - esc: kilepes$' 
menuszovegerteksorveg: db ')$'

test1: db 'test1$'

Code 	Ends
Data 	Segment
Data 	Ends
Stack 	Segment
Stack 	Ends
End 	Start