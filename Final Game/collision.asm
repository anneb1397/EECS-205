; #########################################################################
;
;   collision.asm - Assembly file for EECS205 Assignment 4/5
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
pearlsCollected DWORD 0

.CODE


EnemyEnemyCollision PROC USES ecx ebx edx edi en1:DWORD, en2:DWORD          ;;bounce off each other
    mov ecx, en1
    mov ebx, en2

    cmp (Sprite PTR[ecx]).state, 1                                          ;;attempt #1000000 trying to stop them from thrashing
    je done
    cmp (Sprite PTR[ecx]).state, 1
    je done
    mov edx, (Sprite PTR[ecx]).velX
    mov edi, (Sprite PTR[ecx]).velY
    neg edx
    neg edi
    mov (Sprite PTR[ecx]).velX, edx
    mov (Sprite PTR[ecx]).velY, edi

    mov edx, (Sprite PTR[ebx]).velX
    mov edi, (Sprite PTR[ebx]).velY
    neg edx
    neg edi
    mov (Sprite PTR[ebx]).velX, edx
    mov (Sprite PTR[ebx]).velY, edi

done:
    
    ret
EnemyEnemyCollision ENDP

PlayerEnemyCollision PROC USES ecx ebx enemy:DWORD          ;;oh no, lose hooks, maybe even die, sad

    mov ecx, enemy
    lea ebx, player2
    
CheckPearls:
    cmp pearlsCollected, 0
    jle KillPlayer
    mov pearlsCollected, 0
    INVOKE LosePearls
    jmp done

KillPlayer:
    INVOKE PlayerDied
    jmp done

    
done:
     ret
PlayerEnemyCollision ENDP

PlayerHookCollision PROC USES ecx                               ;;regain hook
    lea ecx, bait
    mov (Sprite PTR[ecx]).onScreen, 0
    mov hooksAvailable, 1
    ret
PlayerHookCollision ENDP

PlayerClamCollision PROC USES ecx ebx pear:DWORD                ;;Woohoo, spawn clam, update points

    mov ecx, pear

MoveClam:
    INVOKE SpawnRandom, pear
    INVOKE ValidPearlLocation
    cmp eax, 1
    jne MoveClam

UpdatePoints:
    inc pearlsCollected

CheckForLevelUp:
    INVOKE LevelCheck
    cmp pearlsCollected, eax
    jl done
    INVOKE IncreaseLevel

done:

    ret
PlayerClamCollision ENDP

EnemyHookCollision PROC enemy:DWORD, b:DWORD                        ;;KillEnemy, lose hook
    mov ecx, enemy
    mov ebx, b
    
KillEnemy:
   INVOKE EnemyDeath, ecx

UpdateHook:
    mov (Sprite PTR[ebx]).onScreen, 0
    mov hooksAvailable, 0

done:
     ret
EnemyHookCollision ENDP

EnemyClamCollision PROC USES ecx ebx en:DWORD                       ;;Bounce off clam
                    LOCAL velX:DWORD, velY:DWORD
    mov ecx, en
    mov ebx, (Sprite PTR[ecx]).velX
    mov velX, ebx
    mov ebx, (Sprite PTR[ecx]).velY
    mov velY, ebx

    cmp velX, 1
    je negX
    mov velX, 1
    jmp ycheck

negX:
    mov velX, -1

ycheck:
    cmp velY, 1
    je negY
    mov velY, 1
    jmp done

negY:
    mov velY, -1

done:
    mov ebx, velY
    mov (Sprite PTR[ecx]).velY, ebx
    mov ebx, velX
    mov (Sprite PTR[ecx]).velX, ebx
    ret
EnemyClamCollision ENDP

EnemyChecks PROC USES ecx ebx edi esi edx eax
                LOCAL s:DWORD, x:DWORD, y:DWORD, bmp:DWORD
    lea ecx, enemies
    mov ebx, ecx                                                        ;;Check collisions of enemies against each other
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
    jne nointer
    INVOKE EnemyEnemyCollision, ecx, ebx
    mov (Sprite PTR[ecx]).state, 1
    mov (Sprite PTR[ebx]).state, 1
    jmp innerincr

nointer:
    mov (Sprite PTR[ecx]).state, 0
    mov (Sprite PTR[ebx]).state, 0

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
EnemyChecks ENDP

CheckAllCollisions PROC USES ecx ebx edx edi esi eax
                    LOCAL plyX:DWORD, plyY:DWORD, plyBmp:DWORD, baitX: DWORD, baitY:DWORD, baitBmp: DWORD, s:DWORD, pearlX:DWorD, pearlY:DWORD, pearlBmp:DWORD

    lea ebx, player2
    mov ecx, (Sprite PTR[ebx]).posX
    mov plyX, ecx
    mov ecx, (Sprite PTR[ebx]).posY
    mov plyY, ecx
    mov ecx, (Sprite PTR[ebx]).bmp
    mov plyBmp, ecx

    lea esi, bait
    mov ecx, (Sprite PTR[esi]).posX
    mov baitX, ecx
    mov ecx, (Sprite PTR[esi]).posY
    mov baitY, ecx
    mov ecx, (Sprite PTR[esi]).bmp
    mov baitBmp, ecx

    lea eax, pearl
    mov ecx, (Sprite PTR[eax]).posX
    mov pearlX, ecx
    mov ecx, (Sprite PTR[eax]).posY
    mov pearlY, ecx
    mov ecx, (Sprite PTR[eax]).bmp
    mov pearlBmp, ecx
    
    
    lea ecx, enemies
    mov edi, 0
    mov s, TYPE enemies

    INVOKE EnemyChecks                                      ;;Check for e-e collisions
    
    jmp cond

CollisionCheck:                                             ;;Check for e-p collision
    mov edx, (Sprite PTR[ecx]).bmp
    INVOKE CheckIntersect, (Sprite PTR[ecx]).posX, (Sprite PTR[ecx]).posY, edx, plyX, plyY, plyBmp
    cmp eax, 1
    jne en_hook
    INVOKE PlayerEnemyCollision, ecx
    jmp next

en_hook:                                                    ;;e-hook
    cmp (Sprite PTR[esi]).onScreen, 1
    jne en_clam
    INVOKE CheckIntersect, (Sprite PTR[ecx]).posX, (Sprite PTR[ecx]).posY, edx, baitX, baitY, baitBmp
    cmp eax, 1
    jne en_clam
    INVOKE EnemyHookCollision, ecx, esi
    jmp next

en_clam:                                                    ;;e-clam/pearl
    INVOKE CheckIntersect, (Sprite PTR[ecx]).posX, (Sprite PTR[ecx]).posY, edx, pearlX, pearlY, pearlBmp
    cmp eax, 1
    jne next
    INVOKE EnemyClamCollision, ecx
    
next:
    inc edi
    add ecx, s

cond:
    cmp edi, enemyLength
    jge clamP
    cmp (Sprite PTR[ecx]).onScreen, 1
    jne next
    cmp (Sprite PTR[ecx]).dead, 0
    je CollisionCheck
    jmp next

clamP:                                                  ;;p-clam/pearl
    lea ecx, pearl
    cmp (Sprite PTR[ecx]).onScreen, 1
    jne hookP
    mov edx, (Sprite PTR[ecx]).bmp
    INVOKE CheckIntersect, (Sprite PTR[ecx]).posX, (Sprite PTR[ecx]).posY, edx, plyX, plyY, plyBmp
    cmp eax, 1
    jne hookP
    INVOKE PlayerClamCollision, ecx

hookP:                                                  ;;p-hook
    cmp (Sprite PTR[esi]).onScreen, 1
    jne done
    INVOKE CheckIntersect, baitX, baitY, baitBmp, plyX, plyY, plyBmp
    cmp eax, 1
    jne done
    INVOKE PlayerHookCollision
done:
    
    ret
CheckAllCollisions ENDP

END