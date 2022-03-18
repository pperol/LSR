%% http://lsr.dsi.unimi.it/LSR/Item?id=307

sop = \relative c'' {
  R1*2 |\break 
  c4 c c c | R1 |\break
  R1*2 | \break
  R1*2 |\break 
  c4 c c c | R1 \bar"|."
}

alt = \relative c'' {
  g4 g g g | R1 | \break |
  R1*2 | \break
  R1*2 | \break
  g4 g g g | R1 | \break |
  g4 g g g | R1 \bar"|."
}

\layout {
  \context { 
    % add the RemoveEmptyStaffContext that erases rest-only staves
    \Staff \RemoveEmptyStaves 
  }
  \context {
    \Score
    % Remove all-rest staves also in the first system
    \override VerticalAxisGroup.remove-first = ##t
    % If only one non-empty staff in a system exists, still print the starting bar
    \override SystemStartBar.collapse-height = #1
  }
  \context {
    \ChoirStaff 
    % If only one non-empty staff in a system exists, still print the bracket
    \override SystemStartBracket.collapse-height = #1
    \override SystemStartBar.collapse-height = #1
  }
}

\score{
  \context ChoirStaff <<
    \context Staff=soprano <<
      \sop
      \set Staff.shortInstrumentName = "S"
    >>
    % never remove empty staves from the alto staff:
    \context Staff=alto \with { \override VerticalAxisGroup.remove-empty = ##f }
    <<
      \alt
      \set Staff.shortInstrumentName = "A"
    >>
  >>
}
