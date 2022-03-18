%% http://lsr.di.unimi.it/LSR/Item?id=219
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/different-editions-from-one-source#using-tags

\layout {
  ragged-right= ##t 
}

common =
\relative c''  {
  c1
  \relative c' <<
    \tag #'part <<
      R1 \\
      {
	\set fontSize = #-1
	c4_"cue" f2 g4 } 
    >>
    \tag #'score R1
  >>
  c1-\tag #'part ^4
}

\simultaneous { 
  \new Staff {
    \set Staff.instrumentName = #"both"
    \common
  }
  \new Staff {
    \set Staff.instrumentName = #"part"
    \keepWithTag #'part \common
  }
  \new Staff {
    \set Staff.instrumentName = #"score"
    \keepWithTag #'score \common
  }
}
