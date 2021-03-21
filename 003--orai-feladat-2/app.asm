Code 	Segment
		assume CS:Code, DS:Data, SS:Stack

Start:
	mov ax, Code
	mov ds, ax
	mov di, offset ertek
	mov ax, 03
	int 10h

Bevitel:
	xor ax, ax
	int 16h

	mov bx,ax
	mov ax, 03
	int 10h

	mov ax,bx
	cmp al, 27
	jz Program_vege

	mov cx, 10
	mov ah, '0' 

Vizsg:
	cmp al, ah
	jz Tarol
	inc ah
	loop Vizsg

	mov ah, 2
	mov bh, 0
	mov dh, 1
	mov dl, 2
	int 10h

	mov dx, offset hiba
	mov ah, 09
	int 21h

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
	
	mov dx, offset ertek
	mov ah, 09
	int 21h
	
	mov ax, offset ertek
	add ax, 4
	cmp ax, di
	jnz Bevitel
	
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
ertek: db '*****$' 
uzenet: db 'Vege a bevitelnek$' 

Code 	Ends
Data 	Segment
Data 	Ends
Stack 	Segment
Stack 	Ends
End 	Start