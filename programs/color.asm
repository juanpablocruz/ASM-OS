bits 16
org 32768
%include 'Malaquias_utils.inc'

start:	
	call cls
	
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
	
	mov si, typetext
	call os_print_string
	call os_print_newline
.loop:
	mov ax, string
	call os_input_string
	mov  si, ax
	
	mov si, di
	call os_string_to_int
	mov [color], ax
	call cls
	
	jmp .loop

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
	mov si, color
	call os_print_string
	mov cx, 01011000b
	call os_draw_background
	ret
	
	color			db  00000000
	clss			db  'cls',0
	osString		db	'Malaquias OS',0
	headertext		db	'Malaquias OS color test',0
	bottomstring 	db	'Color Test program',0
	wellcometest	db	'Welcome to the Malaquias OS Color tester',0
	typetext		db	'In order to test the colors, type any number',0
	presskeystring	db	'Press any key to continue...',0
	string	times 256 db 0