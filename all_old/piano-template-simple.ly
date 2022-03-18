%% http://lsr.dsi.unimi.it/LSR/Item?id=354
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/templates#templates-piano-template-_0028simple_0029

upper = \relative c'' {
  \clef treble
  \key c \major
  \time 4/4

  a4 b c d
}

lower = \relative c {
  \clef bass
  \key c \major
  \time 4/4

  a2 c
}

\score {
  \new PianoStaff <<
    \set PianoStaff.instrumentName = #"Piano  "
    \new Staff = "upper" \upper
    \new Staff = "lower" \lower
  >>
  \layout { }
  \midi { }
}
