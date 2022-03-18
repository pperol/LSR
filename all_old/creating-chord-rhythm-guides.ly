%% http://lsr.di.unimi.it/LSR/Item?id=749


\score {
  <<
    \new ChordNames \chords {
      d4.:m g:7 c4
    }
    \new RhythmicStaff {
      \override NoteHead.style = #'slash
      \override NoteHead.font-size = #-4
      c4. c8~c4 c
    }
    \new Staff { d''8 c'' b' g' a' b' c''4 }
  >>
  \layout {
    \context {
      \RhythmicStaff
      \remove "Time_signature_engraver"
      \remove "Clef_engraver"
      \override BarLine.transparent = ##t
      \override StaffSymbol.line-count = #0
    }
  }
}
