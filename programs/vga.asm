bits 16
org 32768
%INCLUDE "Malaquias_utils.inc"

start:

	mov al,13h		;Sets Graphic mode VGA 256 colors 640x480
	mov ah, 00h
	int 10h
	mov ax,0
	mov bx,0
	mov cx, 01110000b
	call os_draw_background
	call vga_draw_background

	mov ah,02h
	mov dh,1
	mov dl,10
	int 10h	
	mov si,.titulo
	call vga_print_string
	mov si,.texto_1
	mov ah,02h
	mov dh,18
	mov dl,20
	int 10h
	call os_print_newline
	call os_print_string
	mov si, .texto_2
	call os_print_newline
	call os_print_string
	jmp input_command
	
.titulo		db 'El hobbit',0
.texto_1 	db 'Estas en una reconfortante habitacion con forma de tunel',0
.texto_2	db 'Hacia el este esta la puerta redonda verde',0
input			times 256 db 0
exit_string	db 'EXIT',0		
	
input_command:
	call os_print_newline
	mov si,.inpt_line
	call os_print_string

	mov ax, input			; Get command string from user
	call os_input_string
	
	call os_print_newline
	
	mov ax, input
	call os_string_uppercase

	mov si, input

	mov di, exit_string		; 'EXIT' entered?
	call os_string_compare
	jc near exit
	
	jmp input_command
.inpt_line	db '>',0
exit:
	mov al,3h
	mov ah, 00h
	int 10h
	mov ax, 02h
	int 33h
	ret

vga_draw_background:
;START DRAWING BACKGROUND	
	mov ah,0ch
	mov al,0010b
	mov cx, 5
	mov dx, 30
.loop_dibujo:
	cmp dx,150
	je .done_draw
	add cx,1
	cmp cx,310
	je .inc_y
	int 10h
	jmp .loop_dibujo
.inc_y:
	add dx,1
	mov cx,5
	jmp .loop_dibujo
.done_draw:
	call vga_chest
	ret
;END DRAW GREEN BLOCK		
vga_chest:
	mov ah,0ch
	mov al,1111b
	mov cx, 20
	mov dx, 30
	call .loop_linea
	mov cx,20
	call .loop_vertical
	mov cx,60
	mov dx,30
	call .loop_vertical
	mov cx,20
	mov dx,60
	call .loop_linea
	ret
.loop_linea:
	cmp cx,60
	je .done_draw_line
	add cx,1
	int 10h
	jmp .loop_linea
.done_draw_line:
	ret	
.loop_vertical:
	cmp dx,60
	je .done_draw_vertical
	add dx,1
	int 10h
	jmp .loop_vertical
.done_draw_vertical:
	ret		
vga_print_string:
	mov ah, 0Eh
	mov bl, 0100b
.repeat:
	lodsb
	cmp al,0
	je near .done
	int 10h
	jmp .repeat
.done:	
	ret
	