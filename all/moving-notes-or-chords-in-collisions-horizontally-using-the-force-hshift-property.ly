\relative c' {
  <<
    { c8. c16 } 
    \\
    { c4 }
  >>
  <<
    { \once \override NoteColumn.force-hshift = #-2 c8. c16 } 
    \\
    { c4 }
  >>
}
