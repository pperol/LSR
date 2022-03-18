%% http://lsr.di.unimi.it/LSR/Item?id=841
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/common-notation-for-vocal-music
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/vocal-music#vocal-music-aligning-syllables-with-melisma

\score {
  <<
    \new Staff {
      \relative c'' 
      \new Voice = "vocal" {
        c d~^\markup default  d e
        c d~^\markup "right aligned" d e
        c d~^\markup "center aligned" d e
        c d~^\markup "reset to default" d e
      }
    }
    \new Lyrics \lyricsto "vocal" \lyricmode { 
      word word word 
      \set lyricMelismaAlignment = #RIGHT 
      word word word 
      \set lyricMelismaAlignment = #CENTER 
      word word word 
      \unset lyricMelismaAlignment
      word word word 
    }
  >>
}
