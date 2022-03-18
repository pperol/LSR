%% http://lsr.dsi.unimi.it/LSR/Item?id=14
%% see also http://lilypond.org/doc/v2.18/Documentation/learning/fixing-overlapping-notation#the-force_002dhshift-property

\relative c' {
  <<
    { c8. c16 } 
    \\
    { c4 }
  >>
  <<
    { \once \override NoteColumn.force-hshift = #-2 c8. c16 } 
    \\
    { c4 }
  >>
}
