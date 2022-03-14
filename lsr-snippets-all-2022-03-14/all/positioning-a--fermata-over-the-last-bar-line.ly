\header {
  texidoc = "
To position a \\fermata sign over the last bar line, you must use a
specially modified rehearsal mark


\\override Score.RehearsalMark
  #'break-visibility = #begin-of-line-invisible



"
  doctitle = "Positioning a \\fermata over the last bar line"
}
%% http://lsr.di.unimi.it/LSR/Item?id=1

\relative c'' {
  \override Score.RehearsalMark.break-visibility = #begin-of-line-invisible
  c1 \mark \markup { \musicglyph "scripts.ufermata" }
}

