%% http://lsr.di.unimi.it/LSR/Item?id=184
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-as-lines

\relative c'' {
  \time 3/4
  \override Glissando.style = #'zigzag
  c4 c
  \cadenzaOn
  c4\glissando
  \hideNotes
  c,,4 
  \unHideNotes
  \cadenzaOff
  \bar "|"
}
