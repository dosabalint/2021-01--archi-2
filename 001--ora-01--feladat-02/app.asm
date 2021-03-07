Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	DS, AX

	mov ax,3
	int 10h ; 10h 3-as subrutint hívtunk meg

	;80x25 szóköz cursort kiírni , hf-ként
	;videolap doublebuffer ha kört mozgattunk gyorsan villogot
	;nem az a memoT látszódik ahova írunk

Kiir:
	mov ah, 02h
	mov bh, 0 ;videó lap száma
	mov dh, 10 ;kurzor a 10. sorba
	mov dl, 0 ;kurzor a 0. oszlopba
	
	int 10h
	
	mov dx, offset uzenet1
	mov ah, 09h
	int 21h
	
	mov dx, offset szamlalo
	mov ah, 09h
	int 21h
	
	mov dx, offset uzenet2
	mov ah, 09h
	int 21h
	
Bevitel:
	xor ax, ax ;nullázás
	;mov ax,0 -vel egyenlő - de a memória művelet ktsg-es
	;default könyv utasításciklust is tartalmaz alapműveletekre
	int 16h ;várakozás egy billentyű leütésre
	
	;karakterre ascii -t vagy unicode-ot ahsználunk, kruzor esetén scan code-ot használunk
	
	cmp al,27;ha igaz kivonás a kettő nulla akkor 1-es lesz
	jz Program_Vege;igaz feltétel emiatt ha hamis a feltétel a futás megy tovább
	
	cmp al,"a";
	jz Szamol; védett szavak amik nem lehetnek pl a le
	jmp Bevitel;

	
Szamol:
	mov di, offset szamlalo
	mov al, [di]
	cmp al, "9"
	jz Program_Vege
	inc al
	mov [di], al
	jmp Kiir

Program_Vege:
	mov	ax, 4c00h
	int	21h

uzenet1:  db "Az a billentyu $"
uzenet2:  db " alkalommal volt leutve$"
szamlalo: db "0$"

Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start

