%% http://lsr.di.unimi.it/LSR/Item?id=138
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/contexts-explained#top_002dlevel-contexts-_002d-staff-containers

\score  {
  \relative c'' <<
    \new StaffContainer {
      
      %% need << >>, otherwise we descend to the voice inside SA
      << \new Staff { c4 c4 } >>
      \skip 4  % s4 would create staff.
      
      << \new Staff { b4 b4 } >>
    }
    \new StaffContainer {
      \skip 4
      << \context Staff { e d f \bar ":|." } >>
      \skip 4
    }
  >>
  
  \layout {
    \context {
      \Score
      \accepts StaffContainer
      \denies Staff
    }
    \context {
      \type Engraver_group
      \consists "Clef_engraver"
      \consists "Time_signature_engraver"
      \consists "Separating_line_group_engraver"
      \consists "Axis_group_engraver"
      \accepts "Staff"
      \defaultchild "Staff"
      
      \name StaffContainer
    }
    \context {
      \Staff
      \remove "Axis_group_engraver"
      \remove "Separating_line_group_engraver"
      \remove "Clef_engraver"
      \remove "Time_signature_engraver"
    }
  }
}
