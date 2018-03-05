; #########################################################################
;
;   hook.asm - Assembly file for EECS205 Assignment 4/5
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
hook EECS205BITMAP <33, 46, 0c0h,, offset hook + sizeof hook>
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0a4h,0b6h,0b6h
	BYTE 0b6h,0b6h,0a4h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,089h,0b6h,08dh
	BYTE 084h,084h,08dh,0b6h,0a4h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0a0h,0b6h,089h
	BYTE 0c0h,0c0h,0c0h,0c0h,089h,08dh,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0a4h,0b6h
	BYTE 0a0h,0c0h,0c0h,0c0h,0c0h,0a0h,08dh,0cdh,0cdh,0c9h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0a4h
	BYTE 092h,0a0h,0c0h,0c0h,0e0h,0c0h,0c9h,0fbh,0fbh,0ffh,0fbh,0d2h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0a0h,0b6h,064h,0c0h,0c0h,0c0h,0a0h,0fah,0dah,0d6h,0fbh,0fbh,0fbh,0d2h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0adh,0b6h,069h,084h,080h,08dh,0ffh,0d6h,0dbh,0dbh,0dah,0ffh,0fbh,0c9h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0adh,0b6h,092h,06dh,0b2h,0fbh,0dbh,0ffh,0ffh,0b6h,0ffh,0ffh
	BYTE 0d6h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0a0h,08dh,06dh,0d2h,0fbh,0ffh,0ffh,0ffh,0d6h,0ffh
	BYTE 0ffh,0dah,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0adh,092h,0d6h,0fbh,0ffh,092h,0b6h,0fbh
	BYTE 0b6h,0dbh,0dbh,0c4h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0adh,092h,0b2h,0fbh,0fbh,0ffh,0dah
	BYTE 0fbh,0d6h,0dbh,0fbh,0c4h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0a9h,08dh,0adh,0ffh,0dah,0b6h
	BYTE 0fah,0ffh,0fbh,0fbh,0fbh,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,08dh,08dh,0a9h,0fbh,0b6h
	BYTE 0dbh,0dah,0d6h,0d6h,0d6h,0d6h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,08dh,089h,0a4h,0d6h
	BYTE 0dbh,0ffh,0dbh,0b6h,0b6h,0dfh,0adh,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0a0h,092h,0a4h,0a4h
	BYTE 0d6h,0b6h,0b6h,0d6h,0fah,0d6h,0dbh,0adh,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0a4h,0b6h,0a0h
	BYTE 0adh,0fah,0fah,0fbh,0ffh,0ffh,0fah,0b2h,0c4h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0a0h,0a9h,0adh,0a9h,0a4h,0c0h,0c0h,092h,08dh
	BYTE 080h,0d6h,0ffh,0ffh,0fbh,0fbh,0ffh,0fbh,089h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0adh,0fah,0ffh,0ffh,0fbh,0ffh,0d6h,08dh,092h
	BYTE 08dh,0fah,0fbh,0fah,0ffh,0fbh,0ffh,0ffh,0d6h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0adh,0ffh,0fbh,0fbh,0fbh,0fbh,0ffh,0b2h,0b6h
	BYTE 092h,0b6h,0ffh,0ffh,0fah,0fah,0ffh,0ffh,0fah,0a4h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0a4h,0ffh,0ffh,0fbh,0fbh,0ffh,0fbh,0b6h,092h
	BYTE 0b6h,091h,0fah,0fbh,0ffh,0ffh,0fbh,0fah,0d6h,0a9h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0b1h,0ffh,0fbh,0fbh,0fah,0fah,0b6h,092h
	BYTE 0b6h,06dh,0d6h,0fah,0fah,0fah,0ffh,0fbh,0b2h,084h,0c0h,0a0h,069h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0a0h,0d6h,0ffh,0fbh,0ffh,0fah,089h,092h
	BYTE 0dbh,06dh,0b6h,0d6h,0d6h,0d6h,0b2h,0adh,0a8h,0c0h,0c0h,0c0h,0a0h,0b6h,0b2h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0a0h,0d6h,0fbh,0fah,0fbh,0d6h,069h
	BYTE 0b6h,089h,0a4h,0c4h,0c4h,0c4h,0c4h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,092h,0ffh
	BYTE 08dh,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0b2h,0ffh,0ffh,0fbh,0b6h
	BYTE 08dh,069h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,06dh
	BYTE 0b6h,0dbh,089h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,089h,0b2h,0b2h,0b2h
	BYTE 0d2h,0fah,0d1h,0a0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 08dh,092h,092h,06dh,084h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0a4h,0b1h,0d6h
	BYTE 0f6h,0f6h,0fbh,0fbh,0d6h,0a4h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,089h,084h,08dh,0a4h,080h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,089h
	BYTE 0d6h,0f6h,0f6h,0f6h,0fbh,0fbh,0d6h,0a0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0a0h,0c0h,08dh,0a9h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0a0h,0adh,0d6h,0f6h,0f6h,0f6h,0fbh,0d6h,084h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,08dh,08dh,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,069h,0b1h,0d2h,0d6h,0d6h,0b1h,0b2h,0adh,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,08dh,089h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,06dh,06dh,08dh,08dh,08dh,0d6h,0ffh,0adh,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,08dh,0a9h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,089h,092h,08dh,0fah,0fbh,0ffh,0ffh,0a9h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0a0h,0c0h,0c0h,0c0h,0c0h,0c0h,0a0h,092h,0a4h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,084h,092h,091h,0fbh,0ffh,0ffh,0fbh,0a4h,0c0h,0c0h,0c4h
	BYTE 0d1h,0d6h,0fbh,0dah,0d1h,0a4h,0c0h,0c0h,084h,092h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0a0h,0b6h,06dh,0b2h,0fah,0fbh,0b2h,0c0h,0c0h,0adh
	BYTE 0ffh,0ffh,0fah,0ffh,0ffh,0ffh,0fah,0a9h,0c0h,092h,0a9h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,08dh,0b6h,06dh,0b2h,0fah,0a4h,0c0h,0adh
	BYTE 0ffh,0ffh,0fbh,0fbh,0fbh,0ffh,0fah,0fbh,0b2h,069h,0b6h,0a0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,069h,092h,0b6h,06dh,08dh,0c0h,0a4h
	BYTE 0fbh,0fah,0fbh,0ffh,0fbh,0adh,0a9h,0adh,0b2h,06dh,0b6h,084h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0a4h,0d6h,06dh,092h,0b6h,092h,069h
	BYTE 0d6h,0fah,0fbh,0fah,0fbh,0a9h,0c0h,0c0h,064h,092h,0b6h,06dh,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0a9h,0d6h,0d6h,08dh,06dh,092h
	BYTE 0b2h,0fbh,0fbh,0fbh,0fbh,0b1h,064h,089h,092h,0b6h,092h,0b2h,0d6h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0a4h,0d6h,0fah,0fah,0b2h
	BYTE 0b2h,0ffh,0fah,0fah,0ffh,0d6h,06dh,08dh,089h,089h,0a0h,0a9h,0ffh,0d6h,0c0h,0e0h
	BYTE 0e0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,08dh,0fah,0fbh
	BYTE 0ffh,0fah,0fbh,0ffh,0fbh,0d6h,084h,0c0h,0c0h,0c0h,0c0h,0c0h,0a8h,0fbh,0cdh,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0a0h,0b2h
	BYTE 0ffh,0ffh,0fbh,0fbh,0ffh,0d6h,084h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0d6h,0cdh
	BYTE 0c0h,0a9h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0a0h,0adh,0d6h,0fah,0d6h,0b1h,0a4h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0e0h,0a4h
	BYTE 0d6h,0b2h,0a4h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0a0h,0a4h,0a0h,0c0h,0c0h,0e0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0e0h
	BYTE 0c0h,0a0h,0a0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h
	BYTE 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h

END
