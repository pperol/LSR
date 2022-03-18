%% http://lsr.dsi.unimi.it/LSR/Item?id=508

%LSR This bug and its workaround were reported by Alex Shanin.

\new PianoStaff <<
 \new Staff = "RH" { \clef treble \time 3/4 s2.*2 }
 \new Staff = "LH" { \clef bass   \time 3/4 s2.*2 }
 \context Staff = LH
  \relative c' {
   \stemDown % Change into \stemUp to fix the bug
   c,8 [ g'
   \change Staff = RH
   d' a' e' b' ]
   % This makes the second beam look much better.
   \override Beam.concaveness = #0
   b [ e, a, d,
   \change Staff = LH
   g, c, ]
 }
>>

