%% http://lsr.di.unimi.it/LSR/Item?id=511
%% see also http://lilypond.org/doc/v2.18/Documentation/internals/stem_002dinterface

\paper { ragged-right = ##f }

{
  c'16^\markup { traditional } d' r f'
  g'16[^\markup { beams over rests } f' r d']

  % N.B. use Score.Stem to set for the whole score.
  \override Staff.Stem.stemlet-length = #0.75

  c'16[^\markup { stemlets over rests } d' r f']
  g'16[^\markup { stemlets and no rests } f'
  \once \override Rest.transparent = ##t
  r16 d']
}
