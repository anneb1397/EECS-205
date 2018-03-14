; #########################################################################
;
;   spawn.inc - Includes for EECS205 Assignment 4/5
;
;
; #########################################################################

;;Library Definitions

;;Library Functions


;;Library Data
EXTERNDEF enemies:Sprite
EXTERNDEF sharks:Sprite
EXTERNDEF enemyLength:DWORD
EXTERNDEF player2:Sprite
EXTERNDEF pearl:Sprite
EXTERNDEF bait:Sprite


;;User Defined Functions
SpawnPlayer PROTO
SpawnRandom PROTO s:DWORD
ValidLocation PROTO s:DWORD
ValidPearlLocation PROTO
ValidEnemyLocations PROTO