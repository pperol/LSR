%% http://lsr.dsi.unimi.it/LSR/Item?id=115
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/titles#titles-aligning-and-centering-instrument-names

\score {
  \context GrandStaff <<
    \context Staff = "treble" {
      \set GrandStaff.instrumentName = "Violini  "
      \set Staff.instrumentName = " vn I" { c''4 }
    }
    \context Staff = "bass" { \set Staff.instrumentName = " vn II" c''4 }
  >>
}
