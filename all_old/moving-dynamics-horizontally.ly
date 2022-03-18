%% http://lsr.dsi.unimi.it/LSR/Item?id=469
%% see also http://lilypond.org/doc/v2.18/Documentation/learning/moving-objects

%LSR This snippet was contributed by Risto Vääräniemi

dynamicsX = 
#(define-music-function (parser location offset)(number?)
  #{
     \once \override DynamicText.X-offset = $offset
     \once \override DynamicLineSpanner.Y-offset = #0
  #})

dynamicsXY = 
#(define-music-function (parser location offsetX offsetY)(number? number?)
  #{
     \once \override DynamicText.X-offset = $offsetX
     \once \override DynamicLineSpanner.Y-offset = $offsetY
  #})

{
   b'2\f \dynamicsX #-3 b'2\f \dynamicsXY #-3 #-6 b'2\f
}
