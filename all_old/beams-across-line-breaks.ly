%% http://lsr.di.unimi.it/LSR/Item?id=521
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/beams

\relative c'' {
  \override Beam.breakable = ##t
  c8 c[ c] c[ c] c[ c] c[ \break  
  c8] c[ c] c[ c] c[ c] c
}
