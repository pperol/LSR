%% http://lsr.di.unimi.it/LSR/Item?id=351
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/templates#templates-single-staff-template-with-notes-and-lyrics

melody = \relative c' {
  \clef treble
  \key c \major
  \time 4/4

  a4 b c d
}

text = \lyricmode {
  Aaa Bee Cee Dee
}

\score{
  <<
    \new Voice = "one" {
      \autoBeamOff
      \melody
    }
    \new Lyrics \lyricsto "one" \text
  >>
  \layout { }
  \midi { }
}
