%% http://lsr.di.unimi.it/LSR/Item?id=128
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/aligning-objects

\score {
  \context Lyrics \lyricmode {
    foo --
    
    \override LyricText.X-extent = #'(-10.0 . 10.0)
    bar baz
  }
  \layout { raggedright = ##t }
}
