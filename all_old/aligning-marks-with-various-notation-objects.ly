%% http://lsr.di.unimi.it/LSR/Item?id=433
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/aligning-objects

\relative c' {
  e1
  
  % the RehearsalMark will be centered above the Clef
  \override Score.RehearsalMark.break-align-symbols = #'(clef)
  \key a \major
  \clef treble
  \mark \markup { \char ##x2193 }
  e1
  
  % the RehearsalMark will be centered above the TimeSignature
  \override Score.RehearsalMark.break-align-symbols = #'(time-signature)
  \key a \major
  \clef treble
  \time 3/4
  \mark \markup { \char ##x2193 }
  e2.
  
  % the RehearsalMark will be centered above the KeySignature
  \override Score.RehearsalMark.break-align-symbols = #'(key-signature)
  \key a \major
  \clef treble
  \time 4/4
  \mark \markup { \char ##x2193 }
  e1

  \break
  e1
  
  % the RehearsalMark will be aligned with the left edge of the KeySignature
  \once \override Score.KeySignature.break-align-anchor-alignment = #LEFT
  \mark \markup { \char ##x2193 }
  \key a \major
  e1
  
  % the RehearsalMark will be aligned with the right edge of the KeySignature
  \once \override Score.KeySignature.break-align-anchor-alignment = #RIGHT
  \key a \major
  \mark \markup { \char ##x2193 }
  e1
  
  % the RehearsalMark will be aligned with the left edge of the KeySignature
  % and then shifted right by one unit.
  \once \override Score.KeySignature.break-align-anchor = #1
  \key a \major
  \mark \markup { \char ##x2193 }
  e1
}
