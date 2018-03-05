; #########################################################################
;
;   stars.asm - Assembly file for EECS205 Assignment 1
;
;
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive


include stars.inc

.DATA

	;; If you need to, you can place global variables here

.CODE

DrawStarField proc

	;; Place your code here
      invoke DrawStar, 400, 400         ;;call DrawStar func with hardcoded values
      invoke DrawStar, 100, 213         ;;star 2
      invoke DrawStar, 215, 50          ;;star 3
      invoke DrawStar, 40, 13           ;;star 4
      invoke DrawStar, 330, 175         ;;star 5
      invoke DrawStar, 165, 10          ;;star 6
      invoke DrawStar, 600, 300         ;;star 7
      invoke DrawStar, 515, 450         ;;star 8
      invoke DrawStar, 311, 201         ;;star 9
      invoke DrawStar, 623, 236         ;;star 10
      invoke DrawStar, 132, 145         ;;star 11
      invoke DrawStar, 568, 96          ;;star 12
      invoke DrawStar, 603, 10          ;;star 13
      invoke DrawStar, 456, 368         ;;star 14
      invoke DrawStar, 12, 400          ;;star 15
      invoke DrawStar, 468, 215         ;;star 16
	ret  			; Careful! Don't remove this line
DrawStarField endp



END
