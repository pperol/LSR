%% http://lsr.di.unimi.it/LSR/Item?id=609
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/displaying-rhythms

\relative c'' {
  \time 3/4 
  c4 c c
  % Change the style permanently
  \override Staff.TimeSignature.style = #'single-digit
  \time 2/4 
  c4 c
  \time 3/4 
  c4 c c
  % Revert to default style:
  \revert Staff.TimeSignature.style
  \time 2/4
  c4 c
  % single-digit style only for the next time signature
  \once \override Staff.TimeSignature.style = #'single-digit
  \time 5/4
  c4 c c c c
  \time 2/4
  c4 c
}
