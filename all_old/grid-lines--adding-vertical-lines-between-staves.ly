%% http://lsr.dsi.unimi.it/LSR/Item?id=424
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/outside-the-staff.fr.html#grid-lines

\layout {
  \context {
    \Staff
    \consists "Grid_point_engraver" %% active les guides
    gridInterval = #(ly:make-moment 1/4)
  }
  \context {
    \Score
    \consists "Grid_line_span_engraver"
     %% centre les lignes guides horizontalement sous les notes
  }
}

\score {
  \new ChoirStaff <<
    \new Staff \relative c' {
      \stemUp
      c'4. d8 e8 f g4
    }
    \new Staff \relative c {
    %% centre les lignes guides verticalement
      \clef bass
      \stemDown
      c4  g'  f  e
    }
  >>
}
