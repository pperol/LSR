\score {
  {  
    s4 \bar "|"    \mark \markup {  \simple #"|" }
    s \bar "."     \mark \markup {  \simple #"." }
    s \bar "||"    \mark \markup {  \simple #"||" }
    s \bar ".|"    \mark \markup {  \simple #".|" }
    s \bar ".."    \mark \markup {  \simple #".." }
    s \bar "|.|"   \mark \markup {  \simple #"|.|" }
    s \bar "|."    \mark \markup {  \simple #"|." }
    s \bar ";"     \mark \markup {  \simple #";" }
    s \bar "!"     \mark \markup {  \simple #"!" }
    s \bar ".|:"   \mark \markup {  \simple #".|:" }
    s \bar ":..:"  \mark \markup {  \simple #":..:" }
    s \bar ":|.|:" \mark \markup {  \simple #":|.|:" }
    s \bar ":|.:"  \mark \markup {  \simple #":|.:" }
    s \bar ":.|.:" \mark \markup {  \simple #":.|.:" }
    s \bar "[|:"   \mark \markup {  \simple #"[|:" }
    s \bar ":|][|:"\mark \markup {  \simple #":|][|:" }
    s \bar ":|]"   \mark \markup {  \simple #":|]" }
    s \bar ":|."   \mark \markup {  \simple #":|." }
    s \bar "'"     \mark \markup {  \simple #"'" }
    s \bar ""
  }
  \layout {
    \context {
      \Score
      \omit TimeSignature
      \omit Clef
      \override RehearsalMark.padding = #3
    }
  }
}
