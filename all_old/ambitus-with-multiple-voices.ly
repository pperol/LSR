%% http://lsr.di.unimi.it/LSR/Item?id=379
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/vocal-music#vocal-music-adding-ambitus-per-voice

\new Staff \with {
  \consists "Ambitus_engraver"
  }
<<
  \new Voice \relative c'' {
    \voiceOne
    c4 a d e
    f1
  }
  \new Voice \relative c' {
    \voiceTwo
    es4 f g as
    b1
  }
>>
