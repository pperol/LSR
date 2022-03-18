%% http://lsr.di.unimi.it/LSR/Item?id=299
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/vocal-music

mus = {
  \clef F
  c4 d e f | c d e f \bar "||"
  c4 d e f | c d e f \bar "|."
}

\layout {
  \context {
    \ChoirStaff
    \name "SemiChoirStaff"
    \consists "Span_bar_engraver"
    \override SpanBar.stencil =
      #(lambda (grob) 
        (if (string=? (ly:grob-property grob 'glyph-name) "|")
            (set! (ly:grob-property grob 'glyph-name) ""))
        (ly:span-bar::print grob))
  }
  \context {
    \Score
    \accepts SemiChoirStaff
  }
}

\score {
  \new SemiChoirStaff {
    <<
      \new Staff \mus
      \new Staff \mus
    >>
  }
}
