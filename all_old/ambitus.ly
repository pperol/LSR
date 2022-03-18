%% http://lsr.di.unimi.it/LSR/Item?id=222
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/vocal-music#vocal-music-adding-ambitus-per-voice

\layout {
  \context {
    \Voice
    \consists "Ambitus_engraver"
  }
}

<<
  \new Staff {
    \relative c' {
      \time 2/4
      c4 f'
    }
  }
  \new Staff {
    \relative c' {
      \time  2/4
      \key d \major
      cis4 as'
    }
  }
>>



