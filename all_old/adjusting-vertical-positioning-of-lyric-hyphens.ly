%% http://lsr.di.unimi.it/LSR/Item?id=793
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/vocal-music

% Hannes Kuhnert <hannes.kuhnert@gmx.de>
% contributed to LilyPond Snippet Repository <http://lsr.dsi.unimi.it/>
% 1.2.2012

\score {
  <<
    \context Voice="Lied" {
      \relative c' {
        \clef G
        \key c \major
        e2 d c1
      }
    }

    \context Lyrics="Lied" {
      \lyricsto Lied \lyricmode {
        La -- l-e -- lu.
      }
    }
  >>

  \layout {
    \context {
      \Lyrics
      \override LyricHyphen.Y-offset = #0.16
    }
  }
}

\paper {
  #(define fonts
    (make-pango-font-tree
      "Serif"
      "Sans"
      "Monospace"
      (/ 20 20)
    )
  )
}
