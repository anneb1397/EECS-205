; #########################################################################
;
;   AI.asm - Assembly file for EECS205 Assignment 4/5
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

enemiesOnScreen DWORD 1
MAX_ENEMIES DWORD 5

X_MIN DWORD 50
X_MAX DWORD 550
Y_MIN DWORD 50
Y_MAX DWORD 330

hooksAvailable DWORD 1

.CODE

DropHook PROC USES ecx ebx edx edi

    cmp hooksAvailable, 0
    je done
    
    lea ecx, bait                               ;;Drop hook near player's location
    lea ebx, player2
    mov edx, (Sprite PTR[ebx]).posX
    mov (Sprite PTR[ecx]).posX, edx
    
    mov edx, (Sprite PTR[ebx]).posY
    mov (Sprite PTR[ecx]).posY, edx
    mov edx, 50
    sub (Sprite PTR[ecx]).posY, edx

    mov (Sprite PTR[ecx]).onScreen, 1

    dec hooksAvailable

done:
    ret
DropHook ENDP

DeadPosClip PROC USES ecx ebx en:DWORD
    mov ecx, en                                         ;;Clip dead enemies from screen
    mov ebx, (Sprite PTR[ecx]).posY
    cmp ebx, Y_MIN
    jge done
    mov (Sprite PTR[ecx]).onScreen, 0

done:
    ret
DeadPosClip ENDP

ResetDeadEnemies PROC USES ecx edi edx
    lea ecx, enemies                                    ;;Reset all dead enemies to be onScreen and alive
    mov edi, 0

allEn:
    cmp (Sprite PTR[ecx]).dead, 1
    jne next
    mov (Sprite PTR[ecx]).dead, 0
    mov (Sprite PTR[ecx]).onScreen, 1   
    mov edx, OFFSET aggressiveFish                      ;;Reset bmp
    mov (Sprite PTR[ecx]).bmp, edx  

spawn:
    INVOKE SpawnRandom, ecx                             ;;Get random loc
    INVOKE ValidLocation, ecx
    cmp eax, 1
    jne spawn

next:
    inc edi
    add ecx, TYPE enemies

cond:
    cmp edi, enemyLength
    jl allEn
    ret
ResetDeadEnemies ENDP

CheckPos PROC USES ecx ebx en:DWORD
            LOCAL x:DWORD, y:DWORD, velX:DWORD, velY:DWORD
    mov ecx, en
    mov ebx, (Sprite PTR[ecx]).posX
    mov x, ebx
    mov ebx, (Sprite PTR[ecx]).posY
    mov y, ebx
    mov ebx, (Sprite PTR[ecx]).velX
    mov velX, ebx
    mov ebx, (Sprite PTR[ecx]).velY
    mov velY, ebx

CheckforDeath:
    cmp (Sprite PTR[ecx]).dead, 0
    je regular
    INVOKE DeadPosClip, ecx
    jmp done

regular:                                        ;;Bounce off walls of screen
    cmp velX, 1
    jl minXCheck
    mov ebx, x
    cmp ebx, X_MAX
    jl yCheck
    mov (Sprite PTR[ecx]).velX, -1
    jmp yCheck

minXCheck:
    mov ebx, x
    cmp ebx, X_MIN
    jg yCheck
    mov (Sprite PTR[ecx]).velX, 1

yCheck:
    cmp velY, 1
    jl minYCheck
    mov ebx, y
    cmp ebx, Y_MAX
    jl done
    mov (Sprite PTR[ecx]).velY, -1
    jmp done

minYCheck:
    mov ebx, y
    cmp ebx, Y_MIN
    jg done
    mov (Sprite PTR[ecx]).velY, 1

done:
    ret
CheckPos ENDP


EnemyDeath PROC USES ecx en:DWORD
    mov ecx, en
    mov (Sprite PTR[ecx]).dead, 1
    mov (Sprite PTR[ecx]).velX, 0
    mov (Sprite PTR[ecx]).velY, -1
    mov edx, OFFSET deadFish
    mov (Sprite PTR[ecx]).bmp, edx
    ret
EnemyDeath ENDP

UpdateEnemies PROC USES ecx eax ebx edi esi
                LOCAL s:DWORD
    lea ecx, enemies
    mov edi, 0
    mov s, TYPE enemies

Update:                                         ;;Check for boundary breaches
    INVOKE CheckPos, ecx
    mov ebx, (Sprite PTR[ecx]).velX             ;;Add velocities to pos
    mov eax, (Sprite PTR[ecx]).velY
    add (Sprite PTR[ecx]).posX, ebx
    add (Sprite PTR[ecx]).posY, eax
    
next:
    inc edi
    add ecx, s

cond:
    cmp edi, enemyLength
    jge  done
    cmp (Sprite PTR[ecx]).onScreen, 1
    je Update
    jmp next
done:
    ret
UpdateEnemies ENDP

END