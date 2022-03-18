%% http://lsr.dsi.unimi.it/LSR/Item?id=251

withPaddingA = #(define-music-function (parser location padding music) (number? ly:music?)
		 #{ \override TextScript.padding = #padding
		 $music 
		 \revert TextScript.padding #})

withPaddingB = #(define-music-function (parser location padding music) (number? ly:music?)
		 #{ \override TextScript.padding = #(* padding 2)
		 $music 
		 \revert TextScript.padding #})

withPaddingC = #(define-music-function (parser location padding music) (number? ly:music?)
		 #{ \override TextScript.padding = #(+ 1 (* padding 2))
		    $music 
		    \revert TextScript.padding #})

{
  c'^"1"
  \withPaddingA #2
  { c'^"2" c'^"3" }
  c'^"4"
  \withPaddingB #2
  { c'^"5" c'^"6" }
  c'^"7"
  \withPaddingC #2
  { c'^"8" c'^"9" }
  c'^"10"
}
