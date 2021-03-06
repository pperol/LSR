%% http://lsr.dsi.unimi.it/LSR/Item?id=817
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/rhythms#rhythms-non_002ddefault-tuplet-numbers

\relative c'' {
  
  \once \override TupletNumber.text =
    #(tuplet-number::non-default-tuplet-denominator-text 7)
    \tuplet 3/2  { c4. c4. c4. c4. }
  \once \override TupletNumber.text =
    #(tuplet-number::non-default-tuplet-fraction-text 12 7)
    \tuplet 3/2  { c4. c4. c4. c4. }
  \once \override TupletNumber.text =
    #(tuplet-number::append-note-wrapper
      (tuplet-number::non-default-tuplet-fraction-text 12 7) "8")
    \tuplet 3/2  { c4. c4. c4. c4. }

  \once \override TupletNumber.text =
    #(tuplet-number::append-note-wrapper
      tuplet-number::calc-denominator-text "4")
    \tuplet 3/2  { c8 c8 c8 c8 c8 c8 }
  \once \override TupletNumber.text =
    #(tuplet-number::append-note-wrapper
      tuplet-number::calc-fraction-text "4")
    \tuplet 3/2  { c8 c8 c8 c8 c8 c8 }

  \once \override TupletNumber.text =
    #(tuplet-number::fraction-with-notes "4." "8")
    \tuplet 3/2  { c4. c4. c4. c4. }
  \once \override TupletNumber.text =
    #(tuplet-number::non-default-fraction-with-notes 12 "8" 4 "4")
    \tuplet 3/2  { c4. c4. c4. c4. }
    
}
