%% http://lsr.di.unimi.it/LSR/Item?id=402
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/rhythms#rhythms-printing-metronome-and-rehearsal-marks-below-the-staff

\layout { 
  indent = 0
  ragged-right = ##f 
}

{
  % Metronome marks below the staff 
  \override Score.MetronomeMark.direction = #DOWN
  \tempo 8. = 120
  c''1

  % Rehearsal marks below the staff
  \override Score.RehearsalMark.direction = #DOWN
  \mark \default
  c''1
}
