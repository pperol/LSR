%% http://lsr.di.unimi.it/LSR/Item?id=305
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/displaying-rhythms

\paper { indent = 0 }

music = \relative c'' { a1 b2 c4 d8 r }

\score {
  \new Voice {
    \time 4/2 
    \music 
    \time 4/4 
    \shiftDurations #1 #0 { \music } 
    \time 2/4 
    \shiftDurations #2 #0 { \music } 
    \time 4/1 
    \shiftDurations #-1 #0 { \music } 
    \time 8/1 
    \shiftDurations #-2 #0 { \music } 
    \time 6/2 
    \shiftDurations #0 #1 { \music } 
    \time 7/2
    \shiftDurations #0 #2 { \music } 
  }
}
