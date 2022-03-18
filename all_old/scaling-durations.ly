%% http://lsr.di.unimi.it/LSR/Item?id=6
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/writing-rhythms#scaling-durations
%% see also http://lsr.di.unimi.it/LSR/Item?id=324

\relative c'' {
  \time 2/4
  % Alter durations to triplets
  a4*2/3 gis a
  % Normal durations
  a4 a
  % Double the duration of chord
  <a d>4*2
  % Duration of quarter, appears like sixteenth
  b16*4 c4
}
