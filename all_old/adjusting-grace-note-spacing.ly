%% http://lsr.di.unimi.it/LSR/Item?id=685
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/rhythms#rhythms-adjusting-grace-note-spacing


graceNotes = {
  \grace { c4 c8 c16 c32 }
  c8
}

\relative c'' {
  c8
  \graceNotes
  \override Score.GraceSpacing.spacing-increment = #2.0
  \graceNotes
  \revert Score.GraceSpacing.spacing-increment
  \graceNotes
}
