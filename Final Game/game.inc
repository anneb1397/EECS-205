; #########################################################################
;
;   game.inc - Includes for EECS205 Assignment 4/5
;
;
; #########################################################################

;; Library Definitions
MouseInfo STRUCT
 horiz DWORD ?
 vert  DWORD ?
 buttons DWORD ?
MouseInfo ENDS

Sprite STRUCT
    posX DWORD ?
    posY DWORD ?
    velX DWORD ?
    velY DWORD ?
    bmp  DWORD ? 
    dead DWORD ?
    onScreen DWORD ?
    health DWORD ?
    state DWORD ?
Sprite ENDS

MK_CONTROL  = 0008h  ;; The CTRL key is down.
MK_LBUTTON  = 0001h  ;; The left mouse button is down.
MK_MBUTTON  = 0010h  ;; The middle mouse button is down.
MK_RBUTTON  = 0002h  ;; The right mouse button is down.
MK_SHIFT    = 0004h  ;; The SHIFT key is down.
MK_XBUTTON1 = 0020h  ;; The first X button is down.
MK_XBUTTON2 = 0040h  ;; The second X button is down.

;; Library Functions
BlackStarField	PROTO
DrawStr PROTO myStr:PTR BYTE, x:DWORD, y:DWORD, color:DWORD

;; Library Data
EXTERNDEF StarBitmap:EECS205BITMAP
EXTERNDEF MouseStatus:MouseInfo
EXTERNDEF KeyUp:DWORD
EXTERNDEF KeyDown:DWORD
EXTERNDEF KeyPress:DWORD
EXTERNDEF aggressiveFish:EECS205BITMAP
EXTERNDEF clam:EECS205BITMAP
EXTERNDEF mermaidPlayerBase:EECS205BITMAP
EXTERNDEF deadFish:EECS205BITMAP
EXTERNDEF hook:EECS205BITMAP
EXTERNDEF shark:EECS205BITMAP
EXTERNDEF paused:DWORD
EXTERNDEF dead:DWORD
EXTERNDEF currLevel:DWORD
EXTERNDEF advance:DWORD

;; User Defined Functions
GameInit PROTO
GamePlay PROTO
HandleInput PROTO
EnemyCollision PROTO
EnemyMove PROTO






