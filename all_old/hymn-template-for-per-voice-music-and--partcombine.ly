%% http://lsr.dsi.unimi.it/LSR/Item?id=653
%% see also http://lilypond.1069038.n5.nabble.com/LSR-v-2-18-quot-Hymn-Template-for-per-voice-music-and-partcombine-quot-does-not-compile-tc159367.html

%LSR by Carl Sorensen on Jan 19, 2010.
%LSR modified by Ed Gordijn on Feb.2014 for v2.18

soprano = \relative c'' {
  a4 a c b
  c a' g f
}

alto = \relative c' {
  c4 \partcombineApart \override NoteColumn #'force-hshift = #1.7 
     a' c b
  c4 a' g f |
}

tenor = \relative c' {
  g4 g g d
  g4 d d g
}

bass = \relative c {
  d4 d d \partcombineApartOnce d
  g, g g \partcombineApartOnce g'
}

verseOne = \lyricmode {
  \set stanza = #"1."
  This is verse one
  It is more fun
}

verseTwo = \lyricmode {
  \set stanza = #"2."
  This is verse two
  It's good for you
}

\score {
  \new ChoirStaff <<
    \new Staff {
      \key d \major
      <<
        \new NullVoice = "aligner"  \soprano
        \new Voice = "upper" \partcombine \soprano \alto
      >>
    }
    \new Lyrics \lyricsto "aligner" { \verseOne }
    \new Lyrics \lyricsto "aligner" { \verseTwo }
    \new Staff {
       \key c \major
       \clef bass {
         \partcombine \tenor \bass
       }
     }
  >>
}
