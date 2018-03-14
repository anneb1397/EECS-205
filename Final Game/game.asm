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

;; If you need to, you can place global variables here
traps DWORD 0
lives DWORD 3
step DWORD 15
enemyLength DWORD 5
sharkLength DWORD 5

;;Sprite: posX, posY, velX, velY, bmp, dead, onScreen, health, state
enemies Sprite 5 DUP(<200,50,1,-1, OFFSET aggressiveFish,0,1, 20, 0>), 5 DUP(<200,50,2,2,OFFSET aggressiveFish,0,1,20,0>)
player2 Sprite<300,420,?,?, OFFSET mermaidPlayerBase, 0, 1, 3, ?>
sharks Sprite 5 DUP(<10,50,2,-2, OFFSET shark, 0, 1, 50, 0>)
pearl Sprite<360, 100, 0,0, OFFSET clam, 0, 1, 0, ?>
bait Sprite<102,222,0,0, OFFSET hook, 0,0, 0, ?>


.CODE
	


HandleInput PROC USES ecx ebx eax edx

    mov eax, KeyPress

CheckAdvance:
    cmp advance, 1
    jne CheckStart
    cmp eax, VK_RETURN
    jne done
    INVOKE Advance
    jmp done
    
CheckStart:                                     ;;go to first level
    cmp currLevel, 0
    jne CheckPause
    cmp eax, VK_RETURN                       
    jne done
    INVOKE IncreaseLevel
    jmp done
    
    
CheckPause:                                     ;;pause
    cmp eax, VK_P                           
    jne CheckDeath
    INVOKE PauseGame
    jmp done

CheckQuit:                                      ;;go back to start
    cmp paused, 1
    jne CheckDeath
    cmp eax, VK_Q
    INVOKE ReturnToStart
    jmp done    

CheckDeath:                                     ;;go back to start
    cmp dead, 1
    jne KeyCheck
    cmp eax, VK_RETURN
    jne done
    INVOKE ReturnToStart
    jmp done
    
KeyCheck:
    mov ecx, OFFSET player2
    cmp eax, VK_LEFT
    je left
    cmp eax, VK_RIGHT
    je right
    cmp eax, VK_UP
    je up
    cmp eax, VK_DOWN
    je down
    cmp eax, VK_SPACE                      
    je space
    jmp done

left:                                               ;;player movement updates
    mov ebx, (Sprite PTR[ecx]).posX
    sub ebx, step
    mov (Sprite PTR[ecx]).posX, ebx
    INVOKE LeftSprite
    jmp done
right:
    mov ebx, (Sprite PTR[ecx]).posX
    add ebx, step
    mov (Sprite PTR[ecx]).posX, ebx
    INVOKE RightSprite
    jmp done
up:
    mov ebx, (Sprite PTR[ecx]).posY
    sub ebx, step
    mov (Sprite PTR[ecx]).posY, ebx
    INVOKE UpSprite
    jmp done
down:
    mov ebx, (Sprite PTR[ecx]).posY
    add ebx, step
    mov (Sprite PTR[ecx]).posY, ebx
    INVOKE DownSprite
    jmp done

space:                                          ;;drop a hook!
    lea ecx, bait
    cmp (Sprite PTR[ecx]).onScreen, 1          ;;see if hook is already out, if so, skip
    je done
    INVOKE DropHook

done:
    ret
HandleInput ENDP


GameInit PROC USES ecx edi eax
    INVOKE BackgroundMusic

    lea ecx, pearl
    rdtsc
    INVOKE nseed, eax
    INVOKE SpawnRandom, ecx
    mov edi, 0
    lea ecx, enemies

allEn:                                      ;;Get random locs for enemies
    INVOKE SpawnRandom, ecx
    INVOKE ValidLocation, ecx
    cmp eax, 1
    jne allEn

next:
    inc edi
    add ecx, TYPE enemies

cond:
    cmp edi, enemyLength
    jl allEn

    INVOKE ValidEnemyLocations              ;;Check validity of positions
	ret         ;; Do not delete this line!!!
GameInit ENDP


GamePlay PROC USES ecx ebx eax

    INVOKE DrawLevel                      ;;Draw
    INVOKE HandleInput                    ;;Input updates

    cmp currLevel, 0
    je done
    INVOKE CheckAllCollisions             ;;Collision check
    INVOKE UpdateEnemies                  ;;enemy updates


done:
	
	ret         ;; Do not delete this line!!!
GamePlay ENDP



END
