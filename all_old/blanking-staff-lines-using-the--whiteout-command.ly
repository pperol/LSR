%% http://lsr.di.unimi.it/LSR/Item?id=258
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/editorial-annotations#editorial-annotations-blanking-staff-lines-using-the-_005cwhiteout-command


\layout { 
  ragged-right = ##f 
}

\relative c' {
  \override TextScript.extra-offset = #'(2 . 4)
  c2-\markup { \whiteout \pad-markup #0.5 "middle C" } c
} 
