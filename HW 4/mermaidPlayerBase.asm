; #########################################################################
;
;   mermaidPlayerBase.asm - Assembly file for EECS205 Assignment 4/5
;
;
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive

include stars.inc
include lines.inc
include trig.inc
include blit.inc
include game.inc


;; Has keycodes
include keys.inc

.DATA
mermaidPlayerBase EECS205BITMAP <42, 45, 0ffh,, offset mermaidPlayerBase + sizeof mermaidPlayerBase>
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,06ch,024h,024h,024h,06ch,024h
	BYTE 024h,024h,06ch,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,06ch,06ch,0d0h,0f8h,0f8h,0d0h,024h,0d0h,0f8h,0f8h,0d0h,06ch,06ch,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,06ch,0d0h,0f8h,0feh,0feh
	BYTE 0f8h,0f8h,0d0h,0f8h,0f8h,0f8h,0feh,0f8h,0d0h,06ch,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,06ch,0d0h,0feh,0feh,0f8h,0f8h,0f8h,0f8h,0f8h,0f8h,0f8h,0f8h
	BYTE 0f8h,0feh,0feh,0d0h,06ch,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,06ch,0d0h,0feh
	BYTE 0f8h,0f8h,0feh,0f8h,0f8h,0f8h,0f8h,0f8h,0f8h,0f8h,0f8h,0f8h,0f8h,0f8h,0d0h,06ch
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,06ch,0d0h,0f8h,0f8h,0d0h,0feh,0feh,0feh,0f8h,0f8h
	BYTE 0f8h,0f8h,0f8h,0f8h,0feh,0f8h,0d0h,0f8h,0d0h,0d0h,06ch,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 06ch,0f8h,0d0h,0d0h,0f8h,0feh,0feh,0f8h,0feh,0feh,0feh,0feh,0feh,0f8h,0f8h,0feh
	BYTE 0f8h,0d0h,0d0h,0d0h,06ch,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,024h,0d0h,0f8h,06ch,0d0h,0feh,0feh
	BYTE 0f8h,0feh,0feh,0feh,0f8h,0feh,0feh,0f8h,0f8h,0f8h,0f8h,0d0h,06ch,0d0h,06ch,024h
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,06ch,0d0h,0d0h,06ch,0d0h,0feh,0f8h,0f8h,0feh,0feh,0f8h,0f8h,0feh
	BYTE 0f8h,0f8h,0d0h,0f8h,0f8h,0d0h,06ch,0d0h,0d0h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,06ch,0d0h,06ch
	BYTE 0d0h,0f8h,0feh,0f8h,0f8h,0feh,0f8h,0f8h,0d0h,0feh,0f8h,0f8h,0d0h,0f8h,0f8h,0d0h
	BYTE 0d0h,06ch,0d0h,06ch,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,024h,0d0h,0d0h,06ch,0d0h,0f8h,0f8h,0d0h,0f8h,0feh
	BYTE 0f8h,0f8h,0d0h,0f8h,0f8h,0f8h,0d0h,0d0h,0f8h,0d0h,0d0h,06ch,0d0h,06ch,024h,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 024h,0d0h,0d0h,06ch,0d0h,0f8h,0f8h,0d0h,0f8h,0f8h,0f8h,0d0h,0d0h,0d0h,0f8h,0d0h
	BYTE 0d0h,0d0h,0f8h,0d0h,0d0h,06ch,06ch,06ch,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,024h,0d0h,0d0h,06ch,0d0h,0f8h
	BYTE 0f8h,0d0h,0f8h,0f8h,0f8h,0d0h,0d0h,0d0h,0f8h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,06ch
	BYTE 06ch,06ch,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,06ch,0d0h,06ch,06ch,0d0h,0d0h,0f8h,06ch,0d0h,0f8h,0f8h,0d0h
	BYTE 0d0h,0d0h,0d0h,0d0h,0d0h,06ch,0d0h,0d0h,06ch,06ch,06ch,06ch,024h,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,06ch,0d0h
	BYTE 06ch,024h,06ch,0d0h,0f8h,06ch,0d0h,0d0h,0f8h,06ch,0d0h,06ch,0d0h,0d0h,0d0h,06ch
	BYTE 0d0h,0d0h,06ch,024h,06ch,06ch,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,06ch,0d0h,06ch,024h,06ch,06ch,0d0h,0d0h
	BYTE 06ch,0d0h,0d0h,06ch,06ch,06ch,0d0h,0d0h,06ch,0d0h,0d0h,06ch,06ch,024h,06ch,06ch
	BYTE 024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,024h,06ch,06ch,024h,024h,06ch,06ch,0d0h,06ch,06ch,06ch,024h,024h,024h
	BYTE 06ch,06ch,06ch,0d0h,06ch,06ch,024h,024h,024h,06ch,024h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,024h,06ch,024h,0ffh
	BYTE 024h,024h,06ch,06ch,024h,06ch,024h,08eh,0b3h,08eh,024h,06ch,0d0h,06ch,06ch,024h
	BYTE 024h,0ffh,024h,06ch,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,024h,06ch,0ffh,0ffh,064h,0d1h,024h,024h,024h,024h
	BYTE 049h,0d0h,0d0h,06ch,049h,024h,06ch,024h,024h,0d1h,064h,0ffh,0ffh,06ch,024h,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,024h,0ffh,0ffh,064h,0d1h,0fah,0f6h,000h,024h,0d0h,0f8h,0feh,0d0h,06ch,024h
	BYTE 000h,0f6h,0fah,0d1h,064h,0ffh,0ffh,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,064h,0f6h
	BYTE 0fah,0f6h,080h,024h,0f8h,0feh,0f8h,0d0h,0d0h,024h,080h,0f6h,0fah,0f6h,064h,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,064h,0d1h,0fah,0fah,0d1h,064h,024h,0f8h,0f8h
	BYTE 0d0h,0d0h,0d0h,024h,064h,0d1h,0fah,0fah,0d1h,064h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,064h,0f6h,0fah,0f6h,064h,0f6h,024h,0d0h,0f8h,06ch,0d0h,06ch,024h,0f6h,064h
	BYTE 0f6h,0fah,0f6h,064h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,064h,0f6h,0fah,0fah,0d1h,004h
	BYTE 064h,0f6h,06ch,0d0h,06ch,0d0h,024h,0f6h,064h,004h,0d1h,0fah,0fah,0f6h,064h,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,064h,0d1h,0f6h,0f6h,000h,02dh,028h,064h,024h,06ch,06ch,06ch
	BYTE 024h,064h,028h,02dh,000h,0f6h,0f6h,0d1h,064h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,064h
	BYTE 0d1h,0d1h,000h,02dh,028h,02dh,02ch,024h,06ch,024h,02ch,02dh,028h,02dh,000h,0d1h
	BYTE 0d1h,064h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,000h,000h,004h,028h,02dh,02ch
	BYTE 055h,02ch,024h,02ch,055h,02ch,02dh,028h,004h,000h,000h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,004h,028h,055h,02ch,07ah,02ch,07ah,02ch,07ah,02ch
	BYTE 055h,028h,004h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 000h,02dh,028h,055h,02ch,055h,02ch,055h,02ch,055h,028h,02dh,000h,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,004h,028h,07ah,02ch,07ah
	BYTE 028h,07ah,02ch,07ah,028h,004h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,004h,004h,028h,07ah,02ch,055h,02ch,07ah,028h,004h,004h
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 000h,02dh,028h,055h,02ch,055h,028h,02dh,000h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,004h,02dh,028h,055h,028h,055h
	BYTE 028h,02dh,004h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,004h,02ch,055h,02ch,055h,02ch,004h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,004h
	BYTE 055h,004h,004h,004h,055h,004h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,004h,004h,02dh,02ch,02dh,004h,004h
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,02dh,02dh,055h,02dh,055h,004h,055h,02dh,055h,02dh,02dh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,02dh,07ah,055h,02dh,055h,02dh
	BYTE 004h,02dh,055h,02dh,055h,07ah,02dh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,02dh,07ah,02dh,02dh,07ah,02dh,02dh,004h,02dh,02dh,07ah,02dh,02dh
	BYTE 07ah,02dh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,02dh,07ah,02dh,02dh
	BYTE 07ah,02dh,004h,004h,0ffh,004h,004h,02dh,07ah,02dh,02dh,07ah,02dh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,02dh,07ah,02dh,055h,004h,004h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,004h,004h,055h,02dh,07ah,02dh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,02dh
	BYTE 055h,02dh,004h,004h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,004h,004h,02dh
	BYTE 055h,02dh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,02dh,055h,004h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,004h,055h,02dh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,004h,004h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,004h,004h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh

END
