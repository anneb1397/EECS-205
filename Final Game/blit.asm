; #########################################################################
;
;   blit.asm - Assembly file for EECS205 Assignment 3
;
;
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive

include lines.inc
include trig.inc
include blit.inc
include game.inc
include levels.inc


.DATA

	;; If you need to, you can place global variables here
	
.CODE

DrawPixel PROC USES edx ecx eax ebx x:DWORD, y:DWORD, color:DWORD
      ;; screen size: 640px x 480px
      pushad
      cmp x, 0                                  ;;range checks
      jl done

      cmp x, 639
      jg done

      cmp y, 0
      jl done
      
      cmp y, 479
      jg done

      mov ecx, color                            
      mov eax, 640
      mov ebx, y
      mul ebx
      add eax, x
      add eax, ScreenBitsPtr                    ;;640*y + x + ScreenBitsPtr
      mov BYTE PTR[eax], cl                     ;;color byte

done:
      popad

	ret 			; Don't delete this line!!!
DrawPixel ENDP

;;WTF is happening with this function
BasicBlitBad PROC USES ebx ecx esi edi edx eax ptrBitmap:PTR EECS205BITMAP, xcenter:DWORD, ycenter:DWORD
        LOCAL x0:DWORD, y0:DWORD, x:DWORD, y:DWORD, dwWidth:DWORD, lpBytes:DWORD, transparent:BYTE

     mov ecx, ptrBitmap
     mov x, 0
     mov y, 0
     mov edi, (EECS205BITMAP PTR[ecx]).dwWidth
     mov dwWidth, edi
     mov al, (EECS205BITMAP PTR [ecx]).bTransparent
     mov transparent, al
     
     mov eax, xcenter
     mov edi, dwWidth
     sar edi, 1
     sub eax, edi
     mov x0, eax                                    ;;x0 = xcenter - dwWidth / 2

     mov eax, ycenter
     sub eax, edi
     mov y0, eax                                    ;;y0 = ycenter - dwWidth / 2
    
     mov edi, dwWidth
     jmp outercond
     
innerloop:
     cmp x, 0                                       ;; range checks
     jl innercond
     cmp x, 639
     jg innercond
     cmp y, 0
     jl innercond
     cmp y, 479
     jg innercond
     
     mov esi, x
     add esi, x0                                    ;; esi <= x + x0
     mov ebx, y
     add ebx, y0                                    ;; ebx <= y + y0

     mov eax, dwWidth                               ;; eax <= dwWidth
     imul y                                         ;; dwWidth * y
     add eax, x                                     ;; x + (dwWidth * y)

     mov edi, (EECS205BITMAP PTR [ecx]).lpBytes     ;; edi <= lpBytes
     xor edx, edx
     mov dl, BYTE PTR [edi + eax]                   ;;get color byte
     
     cmp transparent, dl                            ;;transparency check
     je innercond
     
     INVOKE DrawPixel, esi, ebx, edx

innercond:
     mov edi, dwWidth
     inc x
     cmp x, edi
     jl innerloop
     inc y
     mov x, 0
outercond:
     cmp y, edi
     jl innercond
     
   
	ret 			; Don't delete this line!!!	
BasicBlitBad ENDP

BasicBlit PROC USES eax ebx ecx edx edi esi ptrBitmap:PTR EECS205BITMAP, xcenter:DWORD, ycenter:DWORD
	                       LOCAL x:DWORD, y:DWORD

	mov ebx, ptrBitmap								
	mov eax, (EECS205BITMAP PTR [ebx]).lpBytes		

	mov ecx, xcenter								
	mov edi, (EECS205BITMAP PTR [ebx]).dwWidth
	sar edi, 1					
	sub ecx, edi				
	mov x, ecx								

	mov edx, ycenter							
	mov edi, (EECS205BITMAP PTR [ebx]).dwHeight
	sar edi, 1
	sub edx, edi				
	mov y, edx								

	mov esi, 0
      mov edi, 0
	mov ecx, (EECS205BITMAP PTR [ebx]).dwWidth		


	jmp outercond

outerloop:
	mov edi, 0								
	mov y, edx
	jmp innercond

innerloop:
	mov ecx, (EECS205BITMAP PTR [ebx]).dwWidth
	imul ecx, edi
	add ecx, esi
	mov cl, BYTE PTR[eax + ecx]					
		
	cmp cl, (EECS205BITMAP PTR [ebx]).bTransparent
	je next
	invoke DrawPixel, x, y, ecx					
next:	
	inc y 								
	inc edi	

innercond:
	cmp edi, (EECS205BITMAP PTR [ebx]).dwHeight	       
	jl innerloop
	
	inc esi 								
	inc x
outercond:
	cmp esi, (EECS205BITMAP PTR [ebx]).dwWidth		
	jl outerloop


	ret 			; Don't delete this line!!!	
BasicBlit ENDP



RotateBlit PROC USES edx ebx ecx edi esi lpBmp:PTR EECS205BITMAP, xcenter:DWORD, ycenter:DWORD, angle:FXPT
        LOCAL cosa:FXPT, sina:FXPT, shiftX:DWORD, shiftY:DWORD, dstWidth:DWORD, dstHeight:DWORD,
                dstX:DWORD, dstY:DWORD, srcX:DWORD, srcY:DWORD, color:BYTE, transparent:BYTE,
                dwWidth:DWORD, dwHeight:DWORD, x:DWORD, y:DWORD

      INVOKE FixedCos, angle
      mov cosa, eax
      INVOKE FixedSin, angle
      mov sina, eax

      mov esi, lpBmp
      mov bl, (EECS205BITMAP PTR[esi]).bTransparent
      mov transparent, bl
      mov ebx, (EECS205BITMAP PTR[esi]).dwWidth
      mov dwWidth, ebx
      mov ebx, (EECS205BITMAP PTR[esi]).dwHeight
      mov dwHeight, ebx
      
      mov eax, dwWidth                                   ;;shiftX calc
      ;;mov ebx, cosa
      imul cosa
      sar eax, 17
      mov shiftX, eax
      
      mov eax, dwHeight
      imul sina
      sar eax, 17
      sub shiftX, eax

      mov eax, dwHeight                                 ;;shiftY calc
      imul cosa
      sar eax, 17
      mov shiftY, eax

      mov eax, dwWidth
      ;;mov ebx, sina
      imul sina
      sar eax, 17
      add shiftY, eax

      mov eax, dwWidth                                  ;;dwWidth and dwHeight initialization
      add eax, dwHeight
      mov dstWidth, eax
      mov dstHeight, eax

      neg eax
      mov dstX, eax                                     ;;dstX = -dstWidth
      
outercond:
      mov ecx, dstX
      cmp ecx, dstWidth                                 ;;dstX < dstWidth
      jge done
      
      mov eax, dstHeight
      neg eax
      mov dstY, eax                                     ;;dstY = -dstHeight
      
innercond:
      mov edx, dstY
      cmp edx, dstHeight                                ;;dstY < dstHeight
      jl innerloop
      inc dstX                                          ;;dstX++
      jmp outercond
      
innerloop:
      mov eax, dstX
      imul cosa                                     ;;dstX * cosa
      sar eax, 16
      mov srcX, eax                                 ;;srcX = distX*cosa
      
      mov eax, dstY
      imul sina                                     ;;dstY * sina
      sar eax, 16
      add srcX, eax                                 ;;srcX = dstX*cosa + dstY*sina

      mov eax, dstY
      imul cosa                                     ;;dstY*cosa
      sar eax, 16
      mov srcY, eax                                 ;;srcY = dstY*cosa
      
      mov eax, dstX
      imul sina                                     ;;dstX*sina
      sar eax, 16
      sub srcY, eax                                 ;;srcY = dstY*cosa - dstX*sina

      mov ebx, srcX
      cmp ebx, 0                                    ;;srcX >= 0
      jl breakloop
      
      cmp ebx, dwWidth                              ;;srcX < dwWidth
      jge breakloop
      
      mov ecx, srcY
      cmp ecx, 0                                    ;;srcY >= 0
      jl breakloop
      
      cmp ecx, dwHeight                             ;;srcY < dwHeight
      jge breakloop

      mov ecx, xcenter
      add ecx, dstX
      sub ecx, shiftX
      mov x, ecx
      cmp x, 0                                      ;;xcenter + dstX - shiftX >= 0
      jl breakloop
      cmp x, 639                                    ;;xcenter + dstX - shiftX < 639
      jge breakloop

      mov ebx, ycenter
      add ebx, dstY
      sub ebx, shiftY
      mov y, ebx
      cmp y, 0                                      ;;ycenter + dstY - shiftY >= 0
      jl breakloop
      cmp y, 479                                    ;;ycenter + dstY - shiftY < 479
      jge breakloop
	
	 mov eax, srcY					        
	 mul dwWidth                                  ;;dwWidth * srcY
	 add eax, srcX                                ;;dwWidth * srcY + srcX
	 add eax, (EECS205BITMAP PTR [esi]).lpBytes   ;;(dwWidth * srcY + srcX) + lpBytes

	 mov cl, BYTE PTR [eax]
       mov color, cl
	 cmp cl, transparent				    ;;transparency check
	 je breakloop

      INVOKE DrawPixel, x, y, color

breakloop:
      inc dstY
      jmp innercond 
done:
	ret 			; Don't delete this line!!!		
RotateBlit ENDP



END
