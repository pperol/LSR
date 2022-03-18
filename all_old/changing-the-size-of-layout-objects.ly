%% http://lsr.di.unimi.it/LSR/Item?id=412
%% see also http://www.lilypond.org/doc/v2.18/Documentation/learning/size-of-objects


\relative c'' {
  \set fontSize = #3
  c4.-> d8---3
  \override NoteHead.font-size = #-4
  c4.-> d8---3
  \override Script.font-size = #3
  c4.-> d8---3
}
