; #########################################################################
;
;   trig.asm - Assembly file for EECS205 Assignment 3
;
;
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive

include trig.inc

.DATA

;;  These are some useful constants (fixed point values that correspond to important angles)
PI_HALF = 102943           	      ;;  PI / 2
PI =  205887	                  ;;  PI 
TWO_PI	= 411774                ;;  2 * PI 
PI_INC_RECIP =  5340353        	;;  Use reciprocal to find the table entry for a given angle
	                              ;;         (It is easier to use than divison would be)


	;; If you need to, you can place global variables here
	
.CODE

FixedSin PROC USES ecx ebx esi edx angle:FXPT
      LOCAL negator:DWORD

	mov ecx, angle
      mov negator, 0                   ;; value to determine if angle is negative
small:
      cmp ecx, 0
      jge large                         ;; is angle within lower bound
      add ecx, TWO_PI                   ;; angle + 2*PI 
      jmp small

large:
      cmp ecx, TWO_PI                   ;; check if angle is within upper bound
      jl zeroPiHalf                     ;; angle in first quadrant
      sub ecx, TWO_PI                   ;; angle - 2*PI
      jmp large
      
zeroPiHalf:
      cmp ecx, PI_HALF
      jg piHalfPi                       ;; angle in second quadrant
      jmp calculate

piHalfPi:
      cmp ecx, PI
      jg piThreePiFourth                ;; angle in third quadrant
      mov ebx, PI
      sub ebx, ecx                      ;; PI - angle
      mov ecx, ebx
      jmp calculate
      
piThreePiFourth:
      mov [negator], 1                  ;; negative angle
      cmp ecx, PI + PI_HALF
      jg threePiFourthTwoPi             ;; angle in fourth quadrant
      add ecx, PI                       ;; angle + PI
      jmp calculate
      
threePiFourthTwoPi:
      mov ebx, TWO_PI
      sub ebx, ecx                      ;; 2*PI - angle
      mov ecx, ebx
      jmp calculate
      
calculate:
      mov eax, ecx
      mov esi, PI_INC_RECIP
      imul esi                          ;; angle * PI_INC_RECIP
      shl edx, 16
      shr edx, 16
      xor eax, eax
      mov ax, [SINTAB + 2*edx]          ;; look up in table
      cmp negator, 0
      je done
      neg eax

done:
	ret			      ; Don't delete this line!!!
FixedSin ENDP 
	
FixedCos PROC USES ecx angle:FXPT

	mov ecx, angle
      add ecx, PI_HALF                  ;; angle + PI/2
      invoke FixedSin, ecx
	ret			      ; Don't delete this line!!!	
FixedCos ENDP	
END
