%% http://lsr.di.unimi.it/LSR/Item?id=460
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/chords#chords-adding-bar-lines-to-chordnames-context

\new ChordNames \with {
  \override BarLine.bar-extent = #'(-2 . 2)
  \consists "Bar_engraver"
}

\chordmode {
  f1:maj7 f:7 bes:7 
}
