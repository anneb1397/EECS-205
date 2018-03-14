; #########################################################################
;
;   math.asm - Assembly file for EECS205 Assignment 4/5
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
include math.inc
include levels.inc
include AI.inc
include effects.inc
include collision.inc
include spawn.inc

;; Has keycodes
include keys.inc

.DATA

.CODE

;;Helper functions for CheckIntersect

GetRight PROC USES ebx x:DWORD, wid:DWORD
    mov ebx, wid
    sar ebx, 1
    mov eax, x
    add eax, ebx                            ;;x + width / 2

    ret
GetRight ENDP

GetLeft PROC USES ebx x:DWORD, wid:DWORD
    mov ebx, wid
    sar ebx, 1
    mov eax, x
    sub eax, ebx                            ;;x - width / 2

    ret
GetLeft ENDP

GetTop PROC USES ebx y:DWORD, height:DWORD
    mov ebx, height
    sar ebx, 1
    mov eax, y
    sub eax, ebx                            ;;y - height / 2

    ret
GetTop ENDP

GetBottom PROC USES ebx y:DWORD, height:DWORD
    mov ebx, height
    sar ebx, 1
    mov eax, y
    add eax, ebx                            ;;y + height / 2

    ret
GetBottom ENDP


CheckIntersect PROC USES ebx ecx oneX:DWORD, oneY:DWORD, oneBitmap:PTR EECS205BITMAP, twoX:DWORD, twoY:DWORD, twoBitmap:PTR EECS205BITMAP
               LOCAL oneWidth: DWORD, oneHeight: DWORD, twoWidth: DWORD, twoHeight: DWORD, oneRightX:DWORD, twoRightX: DWORD, oneLeftX: DWORD, twoLeftX: DWORD
               
    mov ecx, oneBitmap
    mov ebx, twoBitmap
    mov eax, (EECS205BITMAP PTR[ecx]).dwWidth
    mov oneWidth, eax
    mov eax, (EECS205BITMAP PTR[ebx]).dwWidth
    mov twoWidth, eax
    mov eax, (EECS205BITMAP PTR[ecx]).dwHeight
    mov oneHeight, eax
    mov eax, (EECS205BITMAP PTR[ebx]).dwHeight
    mov twoHeight, eax

    xor eax, eax

CheckTop:    
    INVOKE GetTop, oneY, oneHeight                          ;;Get Upper Y values for one
    mov ecx, eax
    INVOKE GetBottom, twoY, twoHeight                       ;;Get Lower Y values for two
    mov ebx, eax
    cmp ecx, ebx                                            ;;oneY < twoY
    jg no_intersect                                         ;;one is completely below two, no intersection

CheckBottom:    
    INVOKE GetTop, twoY, twoHeight                          ;;Get Upper Y values for two
    mov ecx, eax
    INVOKE GetBottom, oneY, oneHeight                       ;;Get Lower Y values for one
    mov ebx, eax
    cmp ecx, ebx                                            ;;twoY < oneY
    jg no_intersect                                         ;;two is completely below one, no intersection

;;the bounding boxes are within the same y range and could be intersecting

FillValues:
    INVOKE GetRight, oneX, oneWidth
    mov oneRightX, eax
    INVOKE GetLeft, oneX, oneWidth
    mov oneLeftX, eax
    INVOKE GetRight, twoX, twoWidth
    mov twoRightX, eax
    INVOKE GetLeft, twoX, twoWidth
    mov twoLeftX, eax

CompareLefts:
    mov ebx, oneLeftX
    cmp ebx, twoLeftX
    jl CheckRight

CompareRights:
    mov ebx, oneRightX
    cmp ebx, twoRightX
    jg CheckLeft
    jmp intersect

CheckRight:
    mov ebx, oneRightX
    cmp ebx, twoLeftX
    jge intersect
    jmp no_intersect

CheckLeft:
    mov ebx, oneLeftX
    cmp ebx, twoRightX
    jle intersect
    jmp no_intersect

intersect:
    mov eax, 1
    jmp done

no_intersect:
    mov eax, 0
done:
    ret
CheckIntersect ENDP

END