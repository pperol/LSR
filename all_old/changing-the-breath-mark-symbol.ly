%% http://lsr.di.unimi.it/LSR/Item?id=454
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-as-curves#breath-marks


\relative c'' {
  c2
  \override BreathingSign.text = 
    \markup { \musicglyph #"scripts.rvarcomma" }
  \breathe
  d2
}
