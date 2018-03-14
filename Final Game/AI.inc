; #########################################################################
;
;   AI.inc - Includes for EECS205 Assignment 4/5
;
;
; #########################################################################

;;Library Definitions


;;Library Functions


;;Library Data
EXTERNDEF enemies:Sprite
EXTERNDEF player2:Sprite
EXTERNDEF bait:Sprite
EXTERNDEF deadFish:EECS205BITMAP
EXTERNDEF aggressiveFish:EECS205BITMAP


;;User Defined Functions
UpdateEnemies PROTO
DropHook PROTO
CheckPos PROTO en:DWORD
EnemyDeath PROTO en:DWORD
DeadPosClip PROTO en:DWORD
ResetDeadEnemies PROTO