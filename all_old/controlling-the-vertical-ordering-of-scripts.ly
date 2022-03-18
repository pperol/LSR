%% http://lsr.di.unimi.it/LSR/Item?id=447
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-attached-to-notes

\relative c''' {
  \once \override TextScript.script-priority = #-100
  a2^\prall^\markup { \sharp }
  
  \once \override Script.script-priority = #-100
  a2^\prall^\markup { \sharp }
}
