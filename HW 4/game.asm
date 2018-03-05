; #########################################################################
;
;   game.asm - Assembly file for EECS205 Assignment 4/5
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


include \masm32\include\user32.inc
includelib \masm32\lib\user32.lib
	
.DATA

Enemy STRUCT

    posX DWORD ?
    posY DWORD ?
    bmp DWORD ?
    dir DWORD ?
    dead DWORD ?
Enemy ENDS

Player STRUCT
    posX DWORD ?
    posY DWORD ?
    dir DWORD ?
    bmp DWORD ?
Player ENDS

Clam STRUCT
    posX DWORD ?
    posY DWORD ?
    onScreen DWORD ?
Clam ENDS

Hook STRUCT
    posX DWORD ?
    posY DWORD ?
    onScreen DWORD ?
Hook ENDS

;; If you need to, you can place global variables here
traps DWORD 0
lives DWORD 3
step DWORD 15
run DWORD 0
player Player<200, 400, OFFSET mermaidPlayerBase>
enemy Enemy<300, 280, OFFSET aggressiveFish, 1, 0>
clamObj Clam<360,100,1>
hookObj Hook<?,?,0>

pearlStr BYTE "You got a pearl! Way to go!", 0
runStr BYTE "Fish: HOOK! SWIM AWAY!", 0
yumStr BYTE "Fish: Hmm... that looks tasty", 0

.CODE
	

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

HandleInput PROC USES ecx ebx eax edx

MouseCheck:
    lea ecx, MouseStatus
    cmp (MouseInfo PTR[ecx]).buttons, MK_LBUTTON
    jne KeyCheck
    mov ebx, (MouseInfo PTR[ecx]).horiz
    mov eax, (MouseInfo PTR[ecx]).vert
    lea ecx, hookObj
    mov (Hook PTR[ecx]).onScreen, 1
    mov (Hook PTR[ecx]).posX, ebx
    mov (Hook PTR[ecx]).posY, eax
    INVOKE BasicBlit, OFFSET hook, (Hook PTR[ecx]).posX, (Hook PTR[ecx]).posY
    lea edx, enemy
    cmp ebx, (Enemy PTR[edx]).posX
    jle negDir
    mov (Enemy PTR[edx]).dir, 1
    jmp KeyCheck
negDir:
    mov (Enemy PTR[edx]).dir, 0
    INVOKE DrawStr, OFFSET runStr, 250, 30, 0ffh
    mov run, 1


KeyCheck:
    mov ecx, OFFSET player
    mov eax, KeyPress
    cmp eax, VK_LEFT
    je left
    cmp eax, VK_RIGHT
    je right
    cmp eax, VK_UP
    je up
    cmp eax, VK_DOWN
    je down
    jmp done

left:
    mov ebx, (Player PTR[ecx]).posX
    sub ebx, step
    mov (Player PTR[ecx]).posX, ebx
    jmp done
right:
    mov ebx, (Player PTR[ecx]).posX
    add ebx, step
    mov (Player PTR[ecx]).posX, ebx
    jmp done
up:
    mov ebx, (Player PTR[ecx]).posY
    sub ebx, step
    mov (Player PTR[ecx]).posY, ebx
    jmp done
down:
    mov ebx, (Player PTR[ecx]).posY
    add ebx, step
    mov (Player PTR[ecx]).posY, ebx
done:
    ret
HandleInput ENDP

ClearScreen PROC USES eax edi ecx
    mov eax, 0
    mov edi, ScreenBitsPtr
    mov ecx, 4b000h
    REP STOSB

  ret
ClearScreen ENDP

EnemyMove PROC USES ecx ebx edx
            LOCAL enemyX:DWORD, dir:DWORD

FillValues:
    lea ebx, enemy
    mov edx, (Enemy PTR[ebx]).posX
    mov enemyX, edx
    mov edx, (Enemy PTR[ebx]).dir

CheckDirection:
    mov ecx, enemyX
    cmp edx, 1
    jne SubPos
    jmp AddPos

SubPos:
    sub ecx, 5
    cmp ecx, 50
    jge done
    mov (Enemy PTR[ebx]).dir, 1

AddPos:
    add ecx, 5
    cmp ecx, 550
    jle done
    mov (Enemy PTR[ebx]).dir, 0

done:
    mov (Enemy PTR[ebx]).posX, ecx
    ret
EnemyMove ENDP

EnemyCollision PROC USES ecx
    lea ecx, enemy
    mov (Enemy PTR[ecx]).dead, 1

    ret
EnemyCollision ENDP

GameInit PROC USES ecx
	
    lea ecx, player
    INVOKE BasicBlit, OFFSET mermaidPlayerBase, (Player PTR[ecx]).posX, (Player PTR[ecx]).posY

	ret         ;; Do not delete this line!!!
GameInit ENDP


GamePlay PROC USES ecx ebx eax

    INVOKE ClearScreen

Draw:
runS:
    mov ecx, run
    cmp ecx, 1
    jne Plyr
    INVOKE DrawStr, OFFSET runStr, 250, 30, 0ffh
Plyr:
    lea ecx, player
    INVOKE BasicBlit, OFFSET mermaidPlayerBase, (Player PTR[ecx]).posX, (Player PTR[ecx]).posY

Hk:
    lea ecx, hookObj
    mov ebx, (Hook PTR[ecx]).onScreen
    cmp ebx, 1
    jne Enmy
    INVOKE BasicBlit, OFFSET hook, (Hook PTR[ecx]).posX, (Hook PTR[ecx]).posY


Enmy:
    lea ecx, enemy
    mov ebx, (Enemy PTR[ecx]).dead
    cmp ebx, 1
    je dead
    INVOKE BasicBlit, OFFSET aggressiveFish, (Enemy PTR[ecx]).posX, (Enemy PTR[ecx]).posY
    jmp Clm
dead:
    INVOKE BasicBlit, OFFSET deadFish, (Enemy PTR[ecx]).posX, (Enemy PTR[ecx]).posY
    
Clm:
    lea ecx, clamObj
    mov ebx, 1
    cmp ebx, (Clam PTR[ecx]).onScreen
    jnz InputUpdate
    INVOKE BasicBlit, OFFSET clam, (Clam PTR[ecx]).posX, (Clam PTR[ecx]).posY
    
InputUpdate:
    INVOKE HandleInput

EnemyMoveUpdate:
    INVOKE EnemyMove


CheckCollision:
    lea ecx, enemy
    mov ebx, (Enemy PTR[ecx]).dead
    cmp ebx, 1
    je secondCheck
    lea ecx, player
    lea ebx, enemy
    INVOKE CheckIntersect, (Player PTR[ecx]).posX, (Player PTR[ecx]).posY, OFFSET mermaidPlayerBase, (Enemy PTR[ebx]).posX, (Enemy PTR[ebx]).posY, OFFSET aggressiveFish
    cmp eax, 1
    jne secondCheck
    INVOKE EnemyCollision


secondCheck:
    lea ebx, clamObj
    mov ecx, (Clam PTR[ebx]).onScreen
    cmp ecx, 1
    jne print
    lea ecx, player
    INVOKE CheckIntersect, (Player PTR[ecx]).posX, (Player PTR[ecx]).posY, OFFSET mermaidPlayerBase,(Clam PTR[ebx]).posX, (Clam PTR[ebx]).posY, OFFSET clam
    cmp eax, 1
    jne done
    mov (Clam PTR[ebx]).onScreen, 0

print:
    INVOKE DrawStr, OFFSET pearlStr, 250, 10, 0ffh


done:
	
	ret         ;; Do not delete this line!!!
GamePlay ENDP



END
