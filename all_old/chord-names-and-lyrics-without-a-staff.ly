%% http://lsr.di.unimi.it/LSR/Item?id=536
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/vocal-music


text = \lyricmode { Ho ho, ho ho ho. Ha ha, ha. }

nullMelody = \relative c'' {
  e4 e e2
  e2 e
  \tuplet 3/2 { d2 c d }
}

harmonies = \chordmode { a1:m | d:m | e:7 | }

\score {
  <<
    \new ChordNames { \harmonies }
    \new Devnull = "vocal" { \nullMelody }
    \new Lyrics \lyricsto "vocal" \text
  >>
  \layout { }
}
