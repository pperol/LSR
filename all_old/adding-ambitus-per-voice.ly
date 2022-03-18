%% http://lsr.di.unimi.it/LSR/Item?id=84
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/vocal-music#vocal-music-adding-ambitus-per-voice

\new Staff <<
  \new Voice \with {
    \consists "Ambitus_engraver"
  } \relative c'' {
    \override Ambitus.X-offset = #2.0
    \voiceOne
    c4 a d e
    f1
  }
  \new Voice \with {
    \consists "Ambitus_engraver"
  } \relative c' {
    \voiceTwo
    es4 f g as
    b1
  }
>>
