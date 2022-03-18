%% http://lsr.di.unimi.it/LSR/Item?id=228
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/proportional-notation

\relative c''
<<
  \set Score.proportionalNotationDuration = #(ly:make-moment 1/16)
  \new Staff { 
    c8[ c c c c c] c4 c2 r2 
  }
  \new Staff { 
    c2 \tuplet 3/2 { c8 c c } c4 c1 
  }
>>
