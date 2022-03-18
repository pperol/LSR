%% http://lsr.di.unimi.it/LSR/Item?id=663
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/staff-notation#staff-notation-creating-blank-staves


\score {
  \new PianoStaff <<
      \new Staff { 
        \repeat unfold 8 { s1 \break } }
      \new Staff { \clef bass \repeat unfold 8 { s1 \break } }
    >>
  \layout {
    indent = 0\in
    \context {
      \Staff
      \remove "Time_signature_engraver"
      %\remove "Clef_engraver"
      \remove "Bar_engraver"
    }
    \context {
      \Score
      \remove "Bar_number_engraver"
    }
  }
}

\paper {
  ragged-last-bottom = ##f
  line-width = 7.5\in
  left-margin = 0.5\in
  bottom-margin = 0.25\in
  top-margin = 0.25\in
}
