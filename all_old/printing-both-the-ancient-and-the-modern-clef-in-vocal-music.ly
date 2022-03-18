%% http://lsr.di.unimi.it/LSR/Item?id=370
%% see also http://lilypond.org/doc/v2.18/Documentation/internals/clef

\relative c' { 
  \once \override Staff.Clef.stencil = #ly:text-interface::print
  \once \override Staff.Clef.text = 
  \markup { \raise #-1 \musicglyph #"clefs.C_change" \musicglyph #"clefs.G" }
  \once \override Staff.Clef.X-extent = #'(0 . 6)
  \clef treble a' b c d \break b c a c
}
\layout {
  indent = 0
  ragged-right = ##t
}
