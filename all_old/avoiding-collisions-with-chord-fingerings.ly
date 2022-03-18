%% http://lsr.di.unimi.it/LSR/Item?id=530
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/chords#chords-avoiding-collisions-with-chord-fingerings


\relative c' {
  \set fingeringOrientations = #'(up)
  \set stringNumberOrientations = #'(up)
  \set strokeFingerOrientations = #'(up)

  % Default behavior
  r8
  <f c'-5>8
  <f c'\5>8
  <f c'-\rightHandFinger #2 >8

  % No tweak needed
  r8
  <f c'-5>8
  <f c'\5>8
   % Corrected to avoid collisions
  \override StrokeFinger.add-stem-support = ##t
  <f c'-\rightHandFinger #2 >8
}
