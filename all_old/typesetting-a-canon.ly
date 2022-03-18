%% http://lsr.di.unimi.it/LSR/Item?id=502

%LSR This snippet was contributed by Mats Bengtsson.

\score {
  <<
    \new Staff \relative c'' {
      \time 3/4
      c4 c c | b b b | a a a | g2 g4 | f f f | e e e | d d d | c2. |
    }
    \new Staff \with {
      \override TimeSignature.stencil = ##f
    } \relative c'' {
      \time 3/4
      e4 e e | d d d | c c c | b2 b4 | a a a | g g g | f f f | e2. |
    }
    \new Staff \with {
      \override TimeSignature.stencil = ##f
    } \relative c'' {
      \time 3/4
      c4 c8 d e f | g4 g, g | a a8 b c d | e2 e,4 | f4 f8 g a b | c4 c, c |
      f4 d b' | c2. |
    }
  >>
  \layout {
    \context {
      \Score
      \remove "System_start_delimiter_engraver"
    }
  }
}
