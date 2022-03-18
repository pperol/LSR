%% http://lsr.dsi.unimi.it/LSR/Item?id=398
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/rhythms#rhythms-modifying-tuplet-bracket-length

\new RhythmicStaff {
  % Set tuplets to be extendable...
  \set tupletFullLength = ##t
  % ...to cover all items up to the next note
  \set tupletFullLengthNote = ##t
  \time 2/4
  \tuplet 3/2 { c4 c c }
  % ...or to cover just whitespace
  \set tupletFullLengthNote = ##f
  \time 4/4
  \tuplet 5/4 { c4 c1 }
  \time 3/4
  c2.
}
