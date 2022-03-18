%% http://lsr.di.unimi.it/LSR/Item?id=471
%% see also http://www.lilypond.org/doc/v2.18/Documentation/internals/arpeggio


\new PianoStaff 
<<
  \set PianoStaff.connectArpeggios = ##t

  \new Staff
  { 
    << { <g'>2 \arpeggio } \\ {  c'2 } \\ { e'2 } >>
    << { <g'>2 \arpeggio } \\ { <c'>2 \arpeggio } \\ { e'2 } >>
  }

  \new Staff
  { 
    \clef bass 
    << { g1 } \\ { <c>1 \arpeggio } \\ { e1 } >>
  }
>>
