%% http://lsr.di.unimi.it/LSR/Item?id=364
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/templates#templates-ancient-notation-template-_002d-modern-transcription-of-gregorian-music


\include "gregorian.ly"

chant = \relative c' {
  f4 a2 \divisioMinima
  g4 b a2 f2 \divisioMaior
  g4( f) f( g) a2 \finalis
}

verba = \lyricmode {
  Lo -- rem ip -- sum do -- lor sit a -- met
}

\score {
  \new Staff <<
    \new Voice = "melody" \chant
    \new Lyrics = "one" \lyricsto melody \verba
  >>
  \layout {
    \context {
      \Staff
      \remove "Time_signature_engraver"
      \remove "Bar_engraver"
      \override Stem.transparent = ##t
    }
    \context {
      \Voice
      \override Stem.length = #0
    }
    \context {
      \Score
      timing = ##f
      barAlways = ##t
      \override SpacingSpanner.packed-spacing = ##f
    }
  }
}
