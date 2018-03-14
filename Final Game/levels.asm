; #########################################################################
;
;   levels.asm - Assembly file for EECS205 Assignment 4/5
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

;;For drawing strings
include \masm32\include\user32.inc
includelib \masm32\lib\user32.lib
	

.DATA
currLevel DWORD 0
paused DWORD 0
dead DWORD 0

advance DWORD 0

levelOnePearls DWORD 10
levelTwoPearls DWORD 25
maxPearls DWORD 40

requiredPearls DWORD 10


welcome BYTE "Welcome to Pearl Collector!", 0
instructions BYTE "Use the arrow keys to move. To drop a fish hook, press space.", 0
instructions2 BYTE "Press P to pause the game.", 0
goal BYTE "Collect pearls to advance, but watch out for angry fish, they like their", 0
goalOver BYTE "treasures!", 0
goal2 BYTE "If a fish catches you, they'll take back their pearls!", 0
goal21 BYTE "And if you don't have any...", 0
play BYTE "Press ENTER to start!", 0

pauseStr BYTE "Game Paused", 0
pauseInstructions BYTE "Press P to resume. Press Q to quit to the main screen.", 0

deathStr BYTE "Oh no! You died and lost your pearls...", 0
deathInstructions BYTE "Press ENTER to retry!", 0

pearlStr BYTE "Uh-oh. You lost all your pearls!", 0
pearlFlag DWORD 0

advanceStr BYTE "Congrats! You made it to the next level!", 0

fmtLevelStr BYTE "Level: %d", 0
outLevelStr BYTE 256 DUP(0)

fmtPearlStr BYTE "Pearls: %d", 0
outPearlStr BYTE 256 DUP(0)

fmtHookStr BYTE "Hooks: %d", 0
outHookStr BYTE 256 DUP(0)

fmtPearlReqStr BYTE "Pearls Needed: %d", 0
outPearlReqStr BYTE 256 DUP(0)


.CODE

LevelCheck PROC
    mov pearlFlag, 0
    
    cmp currLevel, 1
    jne l2
    mov eax, levelOnePearls
    jmp done

l2:
    cmp currLevel, 2
    jne default
    mov eax, levelTwoPearls
    jmp done

default:
    mov eax, maxPearls

done:

    ret
LevelCheck ENDP

IncreaseLevel PROC USES ebx eax
    cmp currLevel, 0
    je noAd
    INVOKE Advance

noAd:
    mov hooksAvailable, 1
    inc currLevel
    cmp currLevel, 1
    je done
    INVOKE LevelUp
    cmp currLevel, 1
    jg higherLevels
    mov ebx, levelOnePearls
    mov requiredPearls, ebx
    jmp done

higherLevels:
    cmp currLevel, 2
    jg bigLeague
    mov ebx, levelTwoPearls
    mov requiredPearls, ebx
    jmp done

bigLeague:
    mov ebx, maxPearls
    mov requiredPearls, ebx
done:
    INVOKE ResetDeadEnemies
    lea ebx, pearl

spawn:
    INVOKE SpawnRandom, ebx
    INVOKE ValidPearlLocation
    cmp eax, 1
    jne spawn

    INVOKE ValidEnemyLocations
    ret
IncreaseLevel ENDP

Advance PROC
    cmp advance, 0
    jne nextScreen
    mov advance, 1
    jmp done

nextScreen:
    mov advance, 0
    INVOKE Danger

done:
    ret
Advance ENDP

LosePearls PROC

prntMessage:
    INVOKE DrawStr, OFFSET pearlStr, 250, 150, 0ffh
    mov pearlFlag, 1                                        ;;To print for the next few draws
    
resetPlayer:
    INVOKE SpawnPlayer

    ret
LosePearls ENDP

ReturnToStart PROC USES ecx
    mov currLevel, 0
    mov dead, 0

    lea ecx, player2
    mov (Sprite PTR[ecx]).dead, 0
    mov (Sprite PTR[ecx]).health, 50
    mov (Sprite PTR[ecx]).posX, 300
    mov (Sprite PTR[ecx]).posY, 400

    mov ecx, levelOnePearls
    mov requiredPearls, ecx

    ret
ReturnToStart ENDP

PauseGame PROC
    cmp paused, 0
    jne unpause
    mov paused, 1
    jmp done

unpause:
    mov paused, 0

done:
    ret
PauseGame ENDP

PlayerDied PROC
    lea ecx, player2
    mov (Sprite PTR[ecx]).dead, 1
    mov dead, 1

    ret
PlayerDied ENDP

ClearScreen PROC USES eax edi ecx
    mov eax, 0
    mov edi, ScreenBitsPtr
    mov ecx, 4b000h
    REP STOSB

  ret
ClearScreen ENDP

DeathScreen PROC
    INVOKE DrawStr, OFFSET deathStr, 250, 150, 0ffh
    INVOKE DrawStr, OFFSET deathInstructions, 250, 175, 0ffh

    ret
DeathScreen ENDP

PauseScreen PROC
    INVOKE DrawStr, OFFSET pauseStr, 250, 150, 0ffh
    INVOKE DrawStr, OFFSET pauseInstructions, 250, 175, 0ffh
    
    ret
PauseScreen ENDP

AdvanceScreen PROC
    INVOKE DrawStr, OFFSET advanceStr, 50, 175, 0ffh
    INVOKE DrawStr, OFFSET play, 200, 200, 0ffh
    ret
AdvanceScreen ENDP

StartScreen PROC
    INVOKE DrawStr, OFFSET welcome, 200, 100, 0ffh
    INVOKE DrawStr, OFFSET instructions, 50, 175, 0ffh
    INVOKE DrawStr, OFFSET instructions2, 200, 200, 0ffh
    INVOKE DrawStr, OFFSET goal, 10, 225, 0ffh
    INVOKE DrawStr, OFFSET goalOver, 280, 240, 0ffh
    INVOKE DrawStr, OFFSET goal2, 60, 265, 0ffh
    INVOKE DrawStr, OFFSET goal21, 230, 280, 0ffh
    INVOKE DrawStr, OFFSET play, 200, 305, 0ffh
    ret
StartScreen ENDP

DrawBackground PROC
    INVOKE BasicBlit, OFFSET Background, 319, 240
    ret
DrawBackground ENDP

DrawPlayer PROC USES ecx ebx
    lea ecx, player2
    mov ebx, (Sprite PTR[ecx]).bmp
    INVOKE BasicBlit, ebx, (Sprite PTR[ecx]).posX, (Sprite PTR[ecx]).posY
    
    ret
DrawPlayer ENDP

DrawEnemies PROC USES ecx ebx edx eax edi esi
                LOCAL s:DWORD

    mov edi, 0
    lea ecx, enemies
    mov s, TYPE enemies
    jmp cond

Draw:
    mov ebx, (Sprite PTR[ecx]).bmp 
     
    INVOKE BasicBlit, ebx, (Sprite PTR[ecx]).posX, (Sprite PTR[ecx]).posY

next:
    inc edi
    add ecx, s

cond:
    cmp edi, enemyLength
    jge  done
    cmp (Sprite PTR[ecx]).onScreen, 1
    je Draw
    jmp next

done:
    
    ret
DrawEnemies ENDP

DrawSharks PROC USES ecx ebx edx eax edi esi
                LOCAL s:DWORD

    mov edi, 0
    lea ecx, sharks
    mov s, TYPE sharks
    jmp cond

Draw:
    mov ebx, (Sprite PTR[ecx]).bmp 
     
    INVOKE BasicBlit, ebx, (Sprite PTR[ecx]).posX, (Sprite PTR[ecx]).posY

next:
    inc edi
    add ecx, s

cond:
    cmp edi, sharkLength
    jge  done
    cmp (Sprite PTR[ecx]).onScreen, 1
    je Draw
    jmp next

done:

    ret
DrawSharks ENDP

DrawClam PROC USES ecx ebx
    lea ecx, pearl
    cmp (Sprite PTR[ecx]).onScreen, 1
    jne done
    mov ebx, (Sprite PTR[ecx]).bmp
    INVOKE BasicBlit, ebx, (Sprite PTR[ecx]).posX, (Sprite PTR[ecx]).posY
done:
    ret
DrawClam ENDP

DrawHooks PROC USES ecx ebx
    lea ecx, bait
    cmp (Sprite PTR[ecx]).onScreen, 1
    jne done
    mov ebx, (Sprite PTR[ecx]).bmp
    INVOKE BasicBlit, ebx, (Sprite PTR[ecx]).posX, (Sprite PTR[ecx]).posY
done:
    ret
DrawHooks ENDP

DrawLevel PROC USES eax

    INVOKE ClearScreen                          ;;Clear screen
    INVOKE DrawBackground                       ;;Draw background

CheckDeath:                                     ;;Check for special screen cases
    cmp dead, 0
    je CheckPause
    INVOKE DeathScreen
    jmp done

CheckPause:
    cmp paused, 0
    je CheckStart
    INVOKE PauseScreen
    jmp done

CheckStart:
    cmp currLevel, 0
    jne CheckAdvance
    INVOKE StartScreen
    jmp done

CheckAdvance:
    cmp advance, 0
    je DrawNormal
    INVOKE AdvanceScreen
    jmp done

DrawNormal:                                     ;;No special screens, draw regular
    INVOKE DrawPlayer
    INVOKE DrawEnemies
    INVOKE DrawClam
    INVOKE DrawHooks

    
DrawUI:                                         ;;Draw UI
    push currLevel
    push offset fmtLevelStr
    push offset outLevelStr
    call wsprintf
    add esp, 12
    INVOKE DrawStr, offset outLevelStr, 10, 10, 255

    push requiredPearls
    push offset fmtPearlReqStr
    push offset outPearlReqStr
    call wsprintf
    add esp, 12
    INVOKE DrawStr, offset outPearlReqStr, 10, 20, 255

    push pearlsCollected
    push offset fmtPearlStr
    push offset outPearlStr
    call wsprintf
    add esp, 12
    INVOKE DrawStr, offset outPearlStr, 550, 10, 255

    push hooksAvailable
    push offset fmtHookStr
    push offset outHookStr
    call wsprintf
    add esp, 12
    INVOKE DrawStr, offset outHookStr, 550, 20, 255
    
    cmp pearlFlag, 0
    je done
    INVOKE DrawStr, OFFSET pearlStr, 250, 150, 0ffh

    
done:
    ret
DrawLevel ENDP


END