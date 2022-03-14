\version "2.18.0"

\header {
  texidoc = "
Ambitus can be added per voice. In this case, the ambitus must be moved
manually to prevent collisions. 

"
  doctitle = "Adding ambitus per voice"
}
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

