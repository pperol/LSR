%% http://lsr.di.unimi.it/LSR/Item?id=490
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/long-repeats

{
 \repeat volta 2 {
   \partial 4
   e'4
   \set Timing.measureLength = #(ly:make-moment 5/4)
   c'2
 }
 \alternative {
   {
     f'4
   }
   {
     a'2 
   }
 }
 \unset Timing.measureLength
 c'1
}
