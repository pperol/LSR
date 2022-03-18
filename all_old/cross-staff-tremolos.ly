%% http://lsr.di.unimi.it/LSR/Item?id=624
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/repeats#repeats-cross_002dstaff-tremolos


\new PianoStaff <<
  \new Staff = "up" \relative c'' {
    \key a \major
    \time 3/8
    s4.
  }
  \new Staff = "down" \relative c'' {
    \key a \major
    \time 3/8
    \voiceOne
    \repeat tremolo 6 {
      <a e'>32
      {
        \change Staff = "up"
        \voiceTwo
        <cis a' dis>32
      }
    }
  }
>>
