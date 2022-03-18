%% http://lsr.di.unimi.it/LSR/Item?id=242
%% see also http://lilypond.org/doc/v2.18/Documentation/learning/visibility-and-color-of-objects


\relative c' {
  \override Accidental.color = #darkgreen
  \override Beam.color = #cyan
  \override NoteHead.color = #darkyellow
  c4
  \override NoteHead.color = #red
  f
  \override NoteHead.color = #darkmagenta
  g
  \override NoteHead.color = #darkblue
  b
  \override NoteHead.color = #green
  \override Stem.color = #blue
  e8 es d dis e4 r
}
