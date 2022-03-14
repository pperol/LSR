\header {
  texidoc = "
The english naming of chords (default) can be changed to german 
(@code{\\germanChords} replaces B and Bes with H and B) or semi-german 
(@code{\\semiGermanChords} replaces B and Bes with H and Bb).




"
  doctitle = "Changing the chord names to German or semi-German notation"
}
scm = \chordmode {
  c1/c | cis/cis
  b1/b | bis/bis | bes/bes
} 


\layout {
  ragged-right = ##t 
  \context {
    \ChordNames
    \consists "Instrument_name_engraver"
  }
}

<<
  \new ChordNames {
    \set instrumentName = #"default"
    \scm
  }
  \new ChordNames {
    \set instrumentName = #"german"
    \germanChords \scm
  }
  \new ChordNames {
    \set instrumentName = #"semi-german"
    \semiGermanChords \scm
  }
  \new ChordNames {
    \set instrumentName = #"italian"
    \italianChords \scm
  }
  \new ChordNames {
    \set instrumentName = #"french"
    \frenchChords \scm
  }
  \context Voice { \scm }
>>
