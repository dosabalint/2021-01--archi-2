Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	DS, AX
	mov ax,3
	int 10h

Kiir:
	mov ah, 02h
	mov bh, 0 ;videó lap száma
	mov dh, 10 ;kurzor a 10. sorba
	mov dl, 0 ;kurzor a 0. oszlopba
	
	int 10h
	
	mov dx, offset uzenet1
	mov ah, 09h
	int 21h
	
	mov dx, offset szamlalo1
	mov ah, 09h
	int 21h
	
	mov dx, offset szamlalo0
	mov ah, 09h
	int 21h
	
	mov dx, offset uzenet2
	mov ah, 09h
	int 21h
	
Bevitel:
	xor ax, ax
	int 16h 
	cmp al, 27
	jz Program_Vege
	jmp Szamol
	
Szamol:
	cmp al, "a"
	jz Novel
	
	cmp al, "d"
	jz Csokkent
	
	jmp Bevitel

Novel:
	mov di, offset szamlalo0 ; szamlalo 0 betoltese
	mov al, [di]
	cmp al, "9"
	jz Tulcsordul

	inc al ; szamlalo 0 novelese
	mov [di], al
	jmp Kiir
    
Tulcsordul:
	mov di, offset szamlalo0 ; szamlalo 0 beallitasa
	mov al, "0"
	mov [di], al
	
	mov di, offset szamlalo1 ; szamlalo 1 betoltese
	mov al, [di]
	cmp al, "9"
	jz Program_Vege
	
	inc al ; szamlalo 1 novelese
	mov [di], al
	jmp Kiir

Csokkent:
	mov di, offset szamlalo0
	mov al, [di]
	cmp al, "0"
	jz Alulcsordul

	dec al
	mov [di], al
	jmp Kiir

Alulcsordul:
	mov di, offset szamlalo1 ; szamlalo 1 betoltese
	mov al, [di]
	cmp al, "0"
	jz Kiir
	dec al ; szamlalo 1 csokkentese
	mov [di], al

	mov di, offset szamlalo0 ; szamlalo 0 beallitasa
	mov al, "9"
	mov [di], al	
	
	jmp Kiir

Program_Vege:
	mov	ax, 4c00h
	int	21h

uzenet1:  db "Az a billentyu $"
uzenet2:  db " alkalommal volt leutve$"
szamlalo0: db "0$"
szamlalo1: db "0$"

Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start

