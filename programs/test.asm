bits 16
org 32768
%INCLUDE "Malaquias_utils.inc"

start:	
	call cls
	mov bl, 0101b
	mov si, osString
	call os_print_string
	call os_print_newline
	call os_print_horiz_line
	call os_print_newline
	
	mov si,presskeystring
	call os_print_string
	call os_wait_for_key
	call os_print_newline
	
	mov si, wellcometest
	call os_print_string
	call os_print_newline
	mov bl,1111b
	mov si, typetext
	call os_print_string
	call os_print_newline
.loop:
	mov ax, string
	call os_input_string
	mov  si, ax
	
	mov di, yess
	call os_string_compare
	jc	yes
	mov di, nos
	call os_string_compare
	jc no
	mov di, clss
	call os_string_compare
	jnc .loop
	call cls
	jmp .loop

yes:
	mov si, yesString
	call os_print_string
	call os_print_newline
	jmp start
no:
	mov si, noString
	call os_print_string
	call os_print_newline
	jmp finish
finish:	
	mov si,presskeystring
	call os_print_string
	call os_wait_for_key
	call os_clear_screen
	ret
cls:
	call os_clear_screen
	mov ax, headertext
	mov	bx, bottomstring
	mov cx, 00001111b
	call os_draw_background
	ret
	
	yess			db	'yes',0
	nos				db  'no',0
	clss			db  'cls',0
	osString		db	'Malaquias OS',0
	headertext		db	'Malaquias OS Assembly test',0
	bottomstring 	db	'Test program',0
	wellcometest	db	'Welcome to the Malaquias OS',0
	typetext		db	'In order to test the keyboard, type any key',0
	yesString		db	'You typed y',0
	noString		db	'You typed n',0
	presskeystring	db	'Press any key to continue...',0
	string	times 256 db 0