%% http://lsr.di.unimi.it/LSR/Item?id=419
%% see also http://lilypond.org/doc/v2.18/Documentation/learning/visibility-and-color-of-objects

\relative c'' {
  \override NoteHead.color = #red
  c4 c
  \override NoteHead.color = #(x11-color 'LimeGreen)
  d
  \override Stem.color = #blue
  e
}
