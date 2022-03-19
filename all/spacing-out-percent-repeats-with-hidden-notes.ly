\new Staff <<

  \new Voice {
    \repeat percent 3 \relative c'' { e e e e }
    \repeat percent 3 \relative c'' { e e e e }
  }
  
  \new Voice {
    s1 s s
    s1 \hideNotes \repeat unfold 8 c4 \unHideNotes 
  }

>>
