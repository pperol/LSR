%% http://lsr.dsi.unimi.it/LSR/Item?id=347
%% see  also http://www.lilypond.org/doc/v2.18/Documentation/notation/writing-parts.fr.html#formatting-cue-notes

%% modified by Harm on Feb 15, 2014
%% http://lilypond.1069038.n5.nabble.com/LSR-v2-18-quot-Cue-with-lyrics-quot-cannot-update-tc159296.html#none

smallerFontsize = { \set fontSize = #-2 }

\addQuote twinkle \new Voice = "cue" \relative c' { c4 c g' g }

\score {
  \new Staff = "cuelyricdemo"
    <<
    \new Voice
      \relative c'' {
        \cueDuring #"twinkle" #1 { R1 }
        a4 a g2
      }
    \new Lyrics = "cueLyrics"
      \lyricsto "cue" {
        \smallerFontsize
        Twink -- le, twink -- le
      }
    >>
}
