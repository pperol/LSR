%% http://lsr.dsi.unimi.it/LSR/Item?id=203
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/beams

% Flat beams at a fixed position.
\layout { indent = #0 }
 { \time 6/4
   c'16 d' e' f'
   c'' d'' e'' f''
   \override Stem.direction = #down
   \override Beam.positions = #'(-6 . -6)
   c'^"override" d' e' f'
   c'' d'' e'' f''
   \override Stem.direction = #up
   \override Beam.positions = #'(6 . 6)
   c'8 d' e'16 f'
   c''32 d'' e'' f''
   \revert Stem.direction
   \revert Beam.positions
   c'16^"revert" d' e' f'
   c'' d'' e'' f''
   c' d' e' f'
   c'' d'' e'' f''
   c'8 d' e'16 f'
   c''32 d'' e'' f''
 }
