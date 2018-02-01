; #########################################################################
;
;   lines.asm - Assembly file for EECS205 Assignment 2
;
;   Anne Barrett
;   abp818
;
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive

include stars.inc
include lines.inc

.DATA

	;; If you need to, you can place global variables here
	
.CODE
	

;; Don't forget to add the USES the directive here
;;   Place any registers that you modify (either explicitly or implicitly)
;;   into the USES list so that caller's values can be preserved
	
;;   For example, if your procedure uses only the eax and ebx registers
;;      DrawLine PROC USES eax ebx x0:DWORD, y0:DWORD, x1:DWORD, y1:DWORD, color:DWORD

DrawLine PROC USES eax edx ebx ecx edi esi x0:DWORD, y0:DWORD, x1:DWORD, y1:DWORD, color:DWORD
	;; Feel free to use local variables...declare them here
	;; For example:
	;; 	LOCAL foo:DWORD, bar:DWORD
	
      LOCAL delta_X: DWORD, delta_Y: DWORD, inc_X: DWORD, inc_Y: DWORD, error: DWORD

	;; Place your code here
      mov eax, x1
      sub eax, x0                           ;;x1 - x0
      cdq
      xor eax, edx
      sub eax, edx
      mov delta_X, eax                      ;;delta_x = abs(x1 - x0)
      mov eax, y1
      sub eax, y0                           ;;y1 - y0
      cdq
      xor eax, edx
      sub eax, edx
      mov delta_Y, eax                      ;;delta_y = abs(y1 - y0)
      mov ebx, x1
      mov inc_X, 1
      cmp x0, ebx
      jge else_X                            ;;x0 >= x1
if_Y:
      mov inc_Y, 1                          ;;inc_y = 1
      mov ebx, y1
      cmp y0, ebx
      jge else_Y                            ;;y0 >= y1
      jmp delta_If                          ;;go to final if
else_X:
      neg inc_X                             ;;inc_x = -1           
      jmp if_Y                              ;;go to second if
else_Y:
      neg inc_Y                             ;;inc_y = -1
delta_If:
      mov ebx, delta_Y
      cmp delta_X, ebx
      jle else_Delta                        ;;delta_X <= delta_Y
      mov eax, delta_X
      mov edx, 0
      mov ebx, 2
      div ebx                               ;;delta_X / 2
      mov error, eax
      jmp end_If                            ;;all three conditionals are done
else_Delta:
      mov edx, 0
      mov eax, delta_Y
      mov ebx, -2
      idiv ebx                              ;;delta_Y / 2
      mov error, eax
end_If:
      mov ebx, x0                           ;;holds curr_x
      mov ecx, y0                           ;;holds curr_y
      invoke DrawPixel, ebx, ecx, color
condition:
      cmp ebx, x1
      jne body
      cmp ecx, y1
      je end_While
body:
      invoke DrawPixel, ebx, ecx, color
      mov edi, error                        ;;prev_error = error
      mov esi, delta_X
      neg esi                               ;;-delta_X
      cmp edi, esi                         
      jle second_If                         ;;prev_error <= -delta_X
      mov esi, delta_Y
      sub error, esi                        ;;error -= delta_Y
      add ebx, inc_X                        ;;curr_x += inc_X
second_If:
      cmp edi, delta_Y
      jge condition                         ;;prev_error >= delta_Y
      mov esi, delta_X
      add error, esi                        ;;error += delta_X
      add ecx, inc_Y                        ;;curr_y += inc_Y
      jmp condition
end_While:
	ret        	;;  Don't delete this line...you need it
DrawLine ENDP




END
