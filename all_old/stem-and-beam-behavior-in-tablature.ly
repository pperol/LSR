%% http://lsr.di.unimi.it/LSR/Item?id=494
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/fretted-strings#fretted-strings-stem-and-beam-behavior-in-tablature 

\new TabStaff {
  \relative c {
    \tabFullNotation
    g16 b d g b d g b
    \stemDown
    \override Beam.concaveness = #10000
    g,,16 b d g b d g b
  }
}
