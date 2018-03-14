; #########################################################################
;
;   collision.inc - Includes for EECS205 Assignment 4/5
;
;
; #########################################################################

;;Library Definitions

;;Library Functions


;;Library Data
EXTERNDEF enemies:Sprite
EXTERNDEF player2:Sprite
EXTERNDEF bait:Sprite
EXTERNDEF pearl:Sprite
EXTERNDEF hooksAvailable:DWORD

;;User Defined Functions
CheckAllCollisions PROTO
PlayerEnemyCollision PROTO enemy:DWORD
PlayerClamCollision PROTO pear:DWORD
PlayerHookCollision PROTO
EnemyHookCollision PROTO enemy:DWORD, b:DWORD
NextEnemyChecks PROTO enemy:DWORD, pos:DWORD
EnemyEnemyCollision PROTO en1:DWORD, en2:DWORD
EnemyClamCollision PROTO en:DWORD