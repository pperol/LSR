%% http://lsr.di.unimi.it/LSR/Item?id=441
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/vocal-music#vocal-music-using-arpeggiobracket-to-make-divisi-more-visible

\include "english.ly"

\score {
  \relative c'' {
    \key a \major
    \time 2/2
    <<
      \new Voice = "upper"
      <<
        { \voiceOne \arpeggioBracket
          a2( b2
          <b d>1\arpeggio)
          <cs e>\arpeggio ~
          <cs e>4
        }
        \addlyrics { \lyricmode { A -- men. } }
      >>
      \new Voice = "lower"
      { \voiceTwo
        a1 ~
        a
        a ~
        a4 \bar "|."
      }      
    >>
  }
  \layout { ragged-right = ##t }
}
