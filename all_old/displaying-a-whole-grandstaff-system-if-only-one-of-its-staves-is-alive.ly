%% http://lsr.di.unimi.it/LSR/Item?id=853
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/contexts-and-engravers#contexts-and-engravers-displaying-a-whole-grandstaff-system-if-only-one-of-its-staves-is-alive


\score {
  <<
    \new StaffGroup = "StaffGroup_woodwinds"
    <<
      \new Staff = "Staff_flute" 
      \with {
        instrumentName = "Flute" 
        shortInstrumentName = "Fl"
      } 
      \relative c' { 
        \repeat unfold 3 { c'4 c c c | c c c c | c c c c | \break }
      }
    >>
    \new StaffGroup = "StaffGroup_Strings"
    <<
      \new GrandStaff = "GrandStaff_violins"
      <<
        \new Staff = "StaffViolinI" \with { 
          instrumentName = "Violin I" 
          shortInstrumentName = "Vi I"
        }
        \relative c'' {
          a1 \repeat unfold 7 { s1 } \repeat unfold 12 a16  a4
        }
        \new Staff = "StaffViolinII" \with { 
          instrumentName = "Violin II" 
          shortInstrumentName = "Vi II"
        }
        \relative c' { e1 \repeat unfold 8 { s1 } }
      >>
      \new Staff = "Staff_cello" \with { 
        instrumentName = "Cello" 
        shortInstrumentName = "Ce"
      }
      \relative c { \clef bass \repeat unfold 9 { c1 }}
    >>
  >>
}
\layout {
  \context {
    \GrandStaff
    \consists Keep_alive_together_engraver
  }
  \context {
    \Staff
    \RemoveEmptyStaves
  }
}
