; #########################################################################
;
;   effects.asm - Assembly file for EECS205 Assignment 4/5
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
include spawn.inc
include collision.inc


;; Has keycodes
include keys.inc

;;For sound
include \masm32\include\windows.inc
include \masm32\include\winmm.inc
includelib \masm32\lib\winmm.lib

.DATA

backgroundPath BYTE "underTheSea.wav", 0
deathSoundPath BYTE "deathSound.wav", 0
collectSoundPath BYTE "levelUp.wav", 0
dangerPath BYTE "poorSouls.wav", 0

left DWORD 0
right DWORD 0
up DWORD 0
down DWORD 0

.CODE

BackgroundMusic PROC
    INVOKE PlaySound, NULL, 0, SND_ASYNC
    INVOKE PlaySound, offset backgroundPath, 0, SND_FILENAME OR SND_ASYNC OR SND_LOOP
    ret
BackgroundMusic ENDP

LevelUp PROC
    INVOKE PlaySound, NULL, 0, SND_ASYNC
    INVOKE PlaySound, offset collectSoundPath, 0, SND_FILENAME OR SND_ASYNC
    ret
LevelUp ENDP

Death PROC
    INVOKE PlaySound, NULL, 0, SND_ASYNC
    INVOKE PlaySound, offset deathSoundPath, 0, SND_FILENAME OR SND_ASYNC
    ret
Death ENDP

Danger PROC
    INVOKE PlaySound, NULL, 0, SND_ASYNC
    INVOKE PlaySound, offset dangerPath, 0, SND_FILENAME OR SND_ASYNC
    ret
Danger ENDP

;;The following functions change the sprite of the player depending on what state of the movement they are in
;;There is one for all four directions

LeftSprite PROC USES ecx edx
    lea ecx, player2
    cmp left, 0
    jg s1
    mov edx, OFFSET mermaidLeftOne
    mov (Sprite PTR[ecx]).bmp, edx
    mov left, 1
    jmp done

s1:
    cmp left, 1
    jg s2
    mov edx, OFFSET mermaidLeftTwo
    mov (Sprite PTR[ecx]).bmp, edx
    mov left, 2
    jmp done

s2:
    mov edx, OFFSET mermaidLeftThree
    mov (Sprite PTR[ecx]).bmp, edx
    mov left, 0

done:
    ret
LeftSprite ENDP

RightSprite PROC USES ecx edx
    lea ecx, player2
    cmp right, 0
    jg s1
    mov edx, OFFSET mermaidRightOne
    mov (Sprite PTR[ecx]).bmp, edx
    mov right, 1
    jmp done

s1:
    cmp right, 1
    jg s2
    mov edx, OFFSET mermaidRightTwo
    mov (Sprite PTR[ecx]).bmp, edx
    mov right, 2
    jmp done

s2:
    mov edx, OFFSET mermaidRightThree
    mov (Sprite PTR[ecx]).bmp, edx
    mov right, 0

done:
    ret
RightSprite ENDP

DownSprite PROC USES ecx edx
    lea ecx, player2
    cmp down, 0
    jg s1
    mov edx, OFFSET mermaidDownOne
    mov (Sprite PTR[ecx]).bmp, edx
    mov down, 1
    jmp done

s1:
    cmp down, 1
    jg s2
    mov edx, OFFSET mermaidDownTwo
    mov (Sprite PTR[ecx]).bmp, edx
    mov down, 2
    jmp done

s2:
    mov edx, OFFSET mermaidDownThree
    mov (Sprite PTR[ecx]).bmp, edx
    mov down, 0

done:
    ret
DownSprite ENDP

UpSprite PROC USES ecx edx
    lea ecx, player2
    cmp up, 0
    jg s1
    mov edx, OFFSET mermaidUpOne
    mov (Sprite PTR[ecx]).bmp, edx
    mov up, 1
    jmp done

s1:
    cmp up, 1
    jg s2
    mov edx, OFFSET mermaidPlayerBase
    mov (Sprite PTR[ecx]).bmp, edx
    mov up, 2
    jmp done

s2:
    mov edx, OFFSET mermaidUpThree
    mov (Sprite PTR[ecx]).bmp, edx
    mov up, 0

done:
    ret
UpSprite ENDP



END