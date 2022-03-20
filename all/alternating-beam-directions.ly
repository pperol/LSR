wipeNote = {
  \once \override NoteHead.transparent = ##t
  \once \override Stem.transparent = ##t 
}

\relative c''<< 
  {
    c8[~ \wipeNote c c~ \wipeNote c c]~ \wipeNote c\noBeam
  } \\ { 
    s8 c[ s c s c] 
  } 
>>
