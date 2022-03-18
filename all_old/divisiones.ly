%% http://lsr.di.unimi.it/LSR/Item?id=104
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/typesetting-gregorian-chant


\include "gregorian.ly"

\score {
  << 
    \context Voice  \transpose c c' {
      \set Score.timing = ##f
      \set Score.barAlways = ##t
      \override TextScript.padding = #3
      \override Staff.BarLine.transparent = ##t
      \override Stem.transparent = ##t
      g4( a) g^\markup { "divisio minima" }
      \divisioMinima
      g4( a) g^\markup { "divisio maior" }
      \divisioMaior
      g4( a) g^\markup { "divisio maxima" }
      \divisioMaxima
      g4( a) g^\markup { "  finalis" }
      \finalis
      g4( a) g
      ^\markup { "virgula" }
      \virgula
      g4( a) g
      ^\markup { "caesura" }
      \caesura
      g4( a) g
    }
    \lyricsto "" \new  Lyrics \lyricmode {
      Blah blub, blah blam.
      Blah blub, blah blam.
      Blah blub, blah blam.
      Blah blub.
    } 
  >>
}
