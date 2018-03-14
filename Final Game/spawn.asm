; #########################################################################
;
;   spawn.asm - Assembly file for EECS205 Assignment 4/5
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
include AI.inc
include effects.inc
include levels.inc
include collision.inc
include spawn.inc


;; Has keycodes
include keys.inc


;;For random
include \masm32\include\masm32.inc
includelib \masm32\lib\masm32.lib

.DATA
X_MIN DWORD 50
X_MAX DWORD 550
Y_MIN DWORD 50
Y_MAX DWORD 300

PLAYER_X DWORD 300
PLAYER_Y DWORD 420

.CODE

ValidLocation PROC USES ebx ecx edx edi s:DWORD
    lea ebx, pearl                                              ;;Compares location of sprite to location of pearl
    mov ecx, s
    mov edx, (Sprite PTR[ecx]).bmp
    mov edi, (Sprite PTR[ebx]).bmp
    INVOKE CheckIntersect, (Sprite PTR[ecx]).posX, (Sprite PTR[ecx]).posY, edx,(Sprite PTR[ebx]).posX, (Sprite PTR[ebx]).posY, edi
    cmp eax, 1
    jne valid
    mov eax, 0
    jmp done

valid:
    mov eax, 1                                                 ;;return 1 if valid

done:
    ret
ValidLocation ENDP

ValidPearlLocation PROC USES ecx ebx edx edi esi                ;;Checks to ensure pearl does not intersect with player
    lea ecx, player2
    lea ebx, pearl
    mov eax, 0
    mov esi, 0
    mov edi, (Sprite PTR[ebx]).bmp
    mov edx, (Sprite PTR[ecx]).bmp
    INVOKE CheckIntersect, (Sprite PTR[ecx]).posX, (Sprite PTR[ecx]).posY, edx,(Sprite PTR[ebx]).posX, (Sprite PTR[ebx]).posY, edi
    cmp eax, 1
    je done
    mov eax, 0
    lea ecx, enemies                                            ;;Checks that pearl does not intersect with enemi
    

checkEn:
    mov edx, (Sprite PTR[ecx]).bmp
    INVOKE CheckIntersect, (Sprite PTR[ecx]).posX, (Sprite PTR[ecx]).posY, edx,(Sprite PTR[ebx]).posX, (Sprite PTR[ebx]).posY, edi

incr:
    inc esi
    add ecx, TYPE enemies
cond:
    cmp eax, 1
    je done
    cmp esi, enemyLength
    jge done
    cmp (Sprite PTR[ecx]).onScreen, 1
    jne done
    jmp checkEn

done:
    cmp eax, 1
    jne valid
    mov eax, 0
    jmp fin

valid:
    mov eax, 1                                                  ;;No intersections, return true

fin:
    
    ret
ValidPearlLocation ENDP

ValidEnemyLocations PROC USES ecx ebx edi esi edx eax
                LOCAL s:DWORD, x:DWORD, y:DWORD, bmp:DWORD
    lea ecx, enemies
    mov ebx, ecx
    mov s, TYPE enemies
    add ebx, s
    mov edi, 1
    mov esi, 0
    jmp outercond
    
outerloop:
    mov edx, (Sprite PTR[ecx]).bmp
    mov bmp, edx
    mov edx, (Sprite PTR[ecx]).posX
    mov x, edx  
    mov edx, (Sprite PTR[ecx]).posY
    mov y, edx
    jmp innercond
    
innerloop:
    mov edx, (Sprite PTR[ebx]).bmp
    INVOKE CheckIntersect, x, y, bmp, (Sprite PTR[ebx]).posX, (Sprite PTR[ebx]).posY, edx
    cmp eax, 1
    jne innerincr

spawn:
    INVOKE SpawnRandom, ecx
    INVOKE ValidLocation, ecx
    cmp eax, 1
    jne spawn

innerincr:
    inc edi
    add ebx, s

innercond:
    cmp edi, enemyLength
    jge outerincr
    cmp (Sprite PTR[ebx]).dead, 1
    je innerincr
    cmp (Sprite PTR[ecx]).onScreen, 1
    jne innerincr
    jmp innerloop


outerincr:
    add ecx, s
    inc esi
    mov edi, esi
    inc edi
    mov ebx, ecx
    add ebx, s

outercond:
    cmp esi, enemyLength
    jge done
    cmp (Sprite PTR[ecx]).dead, 1
    je outerincr
    cmp (Sprite PTR[ecx]).onScreen, 1
    jne outerincr
    jmp outerloop

done:


    ret
ValidEnemyLocations ENDP

SpawnRandom PROC USES ecx esi eax s:DWORD

    mov ecx, s
    push ecx
    push esi
    INVOKE nrandom, X_MAX                       ;;Get a random in less than X_MAX
    pop esi
    pop ecx
    add eax, X_MIN                              ;;Make sure int is greater than X_MIN
    mov (Sprite PTR[ecx]).posX, eax             ;;Change position

    push ecx
    push esi
    INVOKE nrandom, Y_MAX
    pop esi
    pop ecx
    add eax, Y_MIN
    mov (Sprite PTR[ecx]).posY, eax
    
    ret
SpawnRandom ENDP

SpawnPlayer PROC USES ecx ebx                   ;;Spawn player at original starting point
    lea ecx, player2
    mov ebx, PLAYER_X
    mov (Sprite PTR[ecx]).posX, ebx
    mov ebx, PLAYER_Y
    mov (Sprite PTR[ecx]).posY, ebx
    ret
SpawnPlayer ENDP

END