%% http://lsr.dsi.unimi.it/LSR/Item?id=539
%% http://www.lilypond.org/doc/v2.17/Documentation/notation/note-heads

upper = \relative c' {
  \voiceOne
  \clef "treble_8"
  \override NoteHead.style = #'harmonic
  g8 a b c b4 d
  <g b>1
}

lower = \relative c {
  \voiceTwo
  \clef "treble_8"
  e2 d
  g,1
}

\score {
  \new Staff = "guitar" <<
    \context Voice = "upper" { \upper }
    \context Voice = "lower" { \lower }
  >>
  \layout { }
}
