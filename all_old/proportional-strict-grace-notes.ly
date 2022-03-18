%% http://lsr.di.unimi.it/LSR/Item?id=229
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/proportional-notation

\relative c'' {
  \override Score.SpacingSpanner.strict-note-spacing = ##t 
  \set Score.proportionalNotationDuration = #(ly:make-moment 1/12)
  c8[ \grace { c16[ c] } c8 c8 c8] 
  c2 
}  
