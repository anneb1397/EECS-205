; #########################################################################
;
;   effects.inc - Includes for EECS205 Assignment 4/5
;
;
; #########################################################################

;;Library Definitions


;;Library Functions


;;Library Data

EXTERNDEF mermaidLeftOne:EECS205BITMAP
EXTERNDEF mermaidLeftTwo:EECS205BITMAP
EXTERNDEF mermaidLeftThree:EECS205BITMAP

EXTERNDEF mermaidRightOne:EECS205BITMAP
EXTERNDEF mermaidRightTwo:EECS205BITMAP
EXTERNDEF mermaidRightThree:EECS205BITMAP

EXTERNDEF mermaidUpOne:EECS205BITMAP
EXTERNDEF mermaidPlayerBase:EECS205BITMAP
EXTERNDEF mermaidUpThree:EECS205BITMAP

EXTERNDEF mermaidDownOne:EECS205BITMAP
EXTERNDEF mermaidDownTwo:EECS205BITMAP
EXTERNDEF mermaidDownThree:EECS205BITMAP

EXTERNDEF player2:Sprite


;;User Defined Functions
BackgroundMusic PROTO
LevelUp PROTO
Death PROTO
Danger PROTO
LeftSprite PROTO
RightSprite PROTO
UpSprite PROTO
DownSprite PROTO