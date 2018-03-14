; #########################################################################
;
;   levels.inc - Includes for EECS205 Assignment 4/5
;
;
; #########################################################################

;;Library Definitions

;;Library Functions


;;Library Data
EXTERNDEF enemies:Sprite
EXTERNDEF player2:Sprite
EXTERNDEF pearl:Sprite
EXTERNDEF bait:Sprite
EXTERNDEF Background:EECS205BITMAP
EXTERNDEF pearlsCollected:DWORD
EXTERNDEF hooksAvailable:DWORD
EXTERNDEF enemyLength:DWORD
EXTERNDEF sharkLength:DWORD

;;User Defined Functions
LevelCheck PROTO
Advance PROTO
LosePearls PROTO
IncreaseLevel PROTO
ReturnToStart PROTO
PauseGame PROTO
PlayerDied PROTO
ClearScreen PROTO
DeathScreen PROTO
PauseScreen PROTO
StartScreen PROTO
AdvanceScreen PROTO
DrawLevel PROTO