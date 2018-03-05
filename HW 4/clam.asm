; #########################################################################
;
;   clam.asm - Assembly file for EECS205 Assignment 4/5
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
clam EECS205BITMAP <75, 69, 000h,, offset clam + sizeof clam>
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,004h,004h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,005h,009h,00eh,012h
	BYTE 012h,013h,017h,004h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,009h,032h,03bh,03bh,013h,013h,012h,012h,012h,013h,009h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,009h,032h,03bh,03bh
	BYTE 03bh,03bh,03bh,012h,012h,012h,012h,012h,012h,012h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,00eh,037h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,012h,012h
	BYTE 012h,012h,012h,012h,012h,004h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,00eh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,013h,012h,012h,012h,012h,012h,013h
	BYTE 009h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,009h,037h,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,017h,012h,012h,012h,012h,012h,012h,012h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,032h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,017h
	BYTE 012h,012h,012h,012h,012h,012h,013h,005h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,009h,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,037h,03bh,03bh,03bh,03bh,03bh,037h,012h,012h,012h,012h,012h
	BYTE 012h,013h,00eh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,00dh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,000h
	BYTE 032h,03bh,03bh,03bh,017h,012h,012h,012h,012h,012h,012h,012h,012h,013h,004h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,00eh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,037h,000h,032h,03bh,03bh,017h,012h
	BYTE 012h,012h,012h,012h,012h,012h,012h,012h,017h,012h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,00eh,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,004h,009h,03bh,037h,012h,012h,012h,012h,012h,012h,012h
	BYTE 012h,013h,012h,00eh,009h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,009h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 00eh,000h,037h,017h,012h,012h,012h,012h,012h,012h,013h,012h,009h,004h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,004h,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,004h,000h,012h,012h
	BYTE 012h,012h,012h,012h,013h,00eh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,037h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,037h,000h,009h,013h,012h,012h,012h,013h,009h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,009h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,017h,012h,012h,012h,012h,013h,00eh,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,037h,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,017h,012h
	BYTE 012h,012h,012h,012h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,009h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,012h,012h,012h,012h,013h,00eh,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,037h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,012h,012h,012h,012h,013h,009h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,004h,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,012h
	BYTE 012h,012h,012h,013h,009h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,00eh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,012h,012h,012h,012h,013h,00eh
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,037h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,037h,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,012h,012h,012h,012h,012h,012h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,000h,00dh,03bh,03bh,03bh,03bh,03bh
	BYTE 013h,012h,012h,012h,012h,012h,004h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,005h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,037h,000h,009h,03bh,03bh,03bh,03bh,03bh,017h,012h,012h,012h,012h
	BYTE 013h,009h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,009h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,000h
	BYTE 004h,03bh,03bh,03bh,03bh,03bh,017h,012h,012h,012h,012h,012h,012h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,00eh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,009h,000h,037h,03bh,03bh,03bh
	BYTE 03bh,037h,012h,012h,012h,012h,012h,013h,009h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,032h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,037h,000h,005h,03bh,03bh,03bh,03bh,03bh,013h,012h,012h
	BYTE 012h,012h,012h,012h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,032h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,00dh,000h,00eh,03bh,03bh,03bh,03bh,017h,012h,012h,012h,012h,012h,013h,009h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,033h,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,005h,000h,033h
	BYTE 03bh,03bh,03bh,03bh,012h,012h,012h,012h,012h,012h,012h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,037h,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,00eh,037h,03bh,03bh,03bh,03bh,017h
	BYTE 012h,012h,012h,012h,012h,013h,005h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,037h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,012h,012h,012h,012h,012h
	BYTE 013h,00eh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,033h,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,037h,012h,012h,012h,012h,012h,012h,012h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,024h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,032h,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,017h,013h
	BYTE 012h,012h,012h,012h,012h,012h,012h,013h,009h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,06dh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,012h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,017h,012h,012h,012h,012h,012h,012h,012h,012h
	BYTE 012h,012h,012h,012h,000h,000h,000h,000h,000h,000h,000h,000h,000h,024h,0dbh,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,00eh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 017h,012h,012h,012h,012h,012h,012h,012h,012h,012h,012h,013h,013h,012h,012h,000h
	BYTE 000h,000h,000h,06dh,092h,0b6h,0b6h,0b6h,0dbh,0ffh,0dbh,049h,024h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,009h,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,037h,013h,012h,012h,012h,012h,012h
	BYTE 012h,012h,012h,012h,013h,012h,00eh,009h,000h,000h,000h,000h,06dh,0fbh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,06dh,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,005h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,017h,012h,012h,012h,012h,012h,012h,012h,012h,012h,013h,012h,009h
	BYTE 004h,000h,000h,000h,000h,000h,0b6h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0dbh,024h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,017h,012h,012h
	BYTE 012h,012h,012h,012h,012h,012h,013h,012h,009h,000h,000h,000h,000h,000h,000h,000h
	BYTE 0b2h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fbh,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,037h,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,017h,012h,012h,012h,012h,012h,012h,012h,013h
	BYTE 012h,009h,000h,000h,000h,000h,000h,000h,000h,000h,06dh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,004h,037h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,037h,012h,012h,012h,012h,012h,012h,012h,013h,009h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,0dbh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,049h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,004h,009h,032h
	BYTE 037h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,013h,012h,012h,012h
	BYTE 012h,012h,013h,012h,004h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,049h
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0b6h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,00eh,037h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,037h,012h,012h,012h,012h,012h,013h,00eh,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,092h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0dbh,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 037h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,013h,012h,012h,012h,012h,013h,00dh,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,0b6h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,009h,03fh,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,037h,03bh,03bh,03bh,03bh,03bh,03bh,017h,012h,012h,012h,012h
	BYTE 013h,009h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 0b6h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,00eh,032h,037h,037h,03bh,03bh,03bh,037h,005h,000h
	BYTE 037h,03bh,03bh,03bh,03bh,03bh,012h,012h,012h,012h,013h,00eh,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,092h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0dbh,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,004h,005h,005h,000h,009h,037h,03bh,03bh,03bh,03bh,03bh
	BYTE 017h,012h,012h,012h,013h,00eh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,08ah,020h,045h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,005h,037h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,017h,012h,012h,012h,012h
	BYTE 000h,000h,000h,000h,000h,000h,000h,049h,06dh,049h,024h,000h,000h,000h,045h,0f3h
	BYTE 069h,000h,0d7h,0fbh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,049h,000h,06dh,08eh,08eh,08eh,06dh,069h,024h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,00eh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,013h,012h,012h,013h,009h,000h,000h,000h,000h,000h
	BYTE 069h,0f7h,0fbh,0fbh,0fbh,0fbh,0fbh,0d7h,08eh,000h,020h,08ah,000h,069h,0fbh,0fbh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0dbh,000h,08eh,0ffh
	BYTE 0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0f7h,0b2h,06dh,024h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,037h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,012h,012h,012h,012h,000h,000h,000h,000h,000h,08eh,0fbh,0fbh,0fbh,0fbh,0fbh
	BYTE 0fbh,0fbh,0fbh,0fbh,0f7h,069h,000h,000h,000h,0b2h,0fbh,0fbh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,024h,024h,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh
	BYTE 0fbh,0fbh,0fbh,0fbh,0fbh,0b2h,024h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,005h,03bh,03bh,03bh,03bh,03bh,005h,037h,03bh,03bh,03bh,012h,012h,013h,00dh
	BYTE 000h,000h,08ah,069h,024h,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh
	BYTE 0fbh,0f7h,06dh,000h,000h,0b2h,0fbh,0d7h,0dbh,0fbh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0fbh,024h,000h,0b2h,0d7h,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh
	BYTE 0fbh,0fbh,069h,000h,000h,000h,000h,000h,000h,000h,000h,000h,00eh,03bh,03bh,03bh
	BYTE 03bh,03bh,000h,012h,03bh,03bh,03bh,012h,012h,013h,009h,000h,000h,000h,000h,000h
	BYTE 045h,069h,08eh,0d7h,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,045h
	BYTE 000h,06dh,0d7h,0fbh,0fbh,0d7h,0fbh,0fbh,0fbh,0fbh,0b2h,000h,000h,000h,000h,024h
	BYTE 0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0d7h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,005h,037h,03bh,03bh,03bh,03bh,009h,004h,03bh
	BYTE 03bh,03bh,012h,012h,013h,004h,009h,000h,00eh,00eh,00dh,009h,004h,000h,000h,020h
	BYTE 069h,0d3h,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,069h,000h,000h,069h,0b2h
	BYTE 0d6h,0d6h,0b2h,08eh,024h,000h,024h,08eh,0d3h,0f7h,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh
	BYTE 0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0f7h,0f7h,0aeh,000h,020h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,005h,004h,004h,000h,000h,000h,032h,03bh,03bh,012h,012h,012h
	BYTE 000h,00eh,004h,009h,017h,013h,013h,013h,012h,012h,00dh,004h,000h,024h,0aeh,0fbh
	BYTE 0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0d7h,069h,000h,000h,000h,000h,000h,000h,024h
	BYTE 0b2h,0fbh,0fbh,0d3h,08eh,049h,044h,045h,08eh,0d7h,0fbh,0fbh,0fbh,0fbh,0fbh,0f7h
	BYTE 0d3h,0aeh,069h,020h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,037h,03bh,012h,012h,00eh,000h,012h,00dh,000h,012h
	BYTE 012h,012h,012h,012h,012h,013h,013h,012h,009h,000h,020h,08eh,0fbh,0fbh,0fbh,0fbh
	BYTE 0fbh,0fbh,0fbh,0fbh,0fbh,0d7h,0b2h,0b2h,0d7h,0fbh,0fbh,0d3h,069h,000h,000h,004h
	BYTE 005h,009h,009h,000h,000h,020h,069h,08eh,089h,065h,040h,000h,000h,000h,005h,00eh
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,004h,03bh,013h,012h,00eh,005h,013h,012h,000h,00eh,013h,012h,012h,012h,012h
	BYTE 012h,012h,012h,013h,012h,009h,000h,020h,08eh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh
	BYTE 0fbh,0fbh,0fbh,0fbh,08eh,020h,000h,004h,00eh,012h,013h,013h,013h,013h,013h,012h
	BYTE 009h,004h,000h,000h,004h,009h,00dh,012h,012h,017h,009h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,009h,017h,012h
	BYTE 012h,012h,012h,013h,004h,009h,013h,012h,012h,012h,012h,012h,012h,012h,012h,012h
	BYTE 013h,012h,009h,000h,020h,069h,0aeh,0d3h,0d3h,0d3h,0d3h,0aeh,08ah,045h,000h,000h
	BYTE 009h,012h,013h,013h,012h,012h,012h,012h,012h,012h,012h,013h,013h,012h,012h,013h
	BYTE 013h,013h,012h,013h,00eh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,00eh,013h,012h,012h,012h,013h,009h
	BYTE 004h,013h,012h,012h,012h,012h,013h,012h,012h,012h,012h,012h,012h,013h,012h,009h
	BYTE 000h,000h,020h,020h,020h,000h,000h,000h,009h,00eh,012h,013h,012h,012h,012h,012h
	BYTE 012h,012h,012h,012h,012h,012h,012h,012h,012h,012h,012h,012h,012h,012h,012h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,012h,013h,012h,012h,012h,00eh,000h,012h,012h,012h,012h
	BYTE 012h,017h,03bh,017h,012h,012h,012h,012h,012h,012h,013h,012h,00eh,009h,009h,009h
	BYTE 00eh,012h,012h,013h,013h,012h,012h,012h,012h,012h,012h,012h,013h,017h,017h,013h
	BYTE 012h,012h,012h,012h,012h,012h,012h,012h,012h,004h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,00eh,013h,012h,012h,012h,000h,009h,013h,012h,012h,012h,012h,03bh,03bh,03bh
	BYTE 017h,013h,012h,012h,012h,012h,012h,012h,013h,013h,013h,013h,012h,012h,012h,012h
	BYTE 012h,012h,012h,012h,017h,017h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,037h,017h,017h
	BYTE 017h,017h,017h,009h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,009h,012h,013h
	BYTE 012h,000h,000h,00eh,013h,012h,012h,012h,037h,03bh,03bh,03bh,03bh,037h,017h,012h
	BYTE 012h,012h,012h,012h,012h,012h,012h,012h,012h,012h,012h,012h,013h,017h,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,00eh,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,00eh,00eh,000h,000h,000h,00eh
	BYTE 013h,012h,012h,017h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,037h,017h,017h,012h,012h
	BYTE 012h,012h,012h,012h,017h,017h,037h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,00eh,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,00eh,013h,012h,012h,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,037h,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,00dh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,009h,012h,012h,017h,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,009h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,004h,00eh,017h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,033h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 005h,013h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,037h,009h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,009h,037h,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,037h,032h,005h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,004h,009h,032h,037h,03bh,03bh
	BYTE 03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,037h,037h,032h,00dh,005h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,004h,009h,009h,009h,009h,009h
	BYTE 009h,009h,009h,005h,004h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h

END