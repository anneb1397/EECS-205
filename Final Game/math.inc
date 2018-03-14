; #########################################################################
;
;   math.inc - Includes for EECS205 Assignment 4/5
;
;
; #########################################################################

;;Library Definitions


;;Library Functions


;;Library Data


;;User Defined Functions
GetTop PROTO y:DWORD, height:DWORD
GetBottom PROTO y:DWORD, height:DWORD
GetLeft PROTO x:DWORD, wid:DWORD
GetRight PROTO x:DWORD, wid:DWORD
CheckIntersect PROTO oneX:DWORD, oneY:DWORD, oneBitmap:PTR EECS205BITMAP, twoX:DWORD, twoY:DWORD, twoBitmap:PTR EECS205BITMAP 
