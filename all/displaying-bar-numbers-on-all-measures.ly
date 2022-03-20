\score{
  \relative c'{
    c1 c c
    \override Score.BarNumber.break-visibility = #end-of-line-invisible
    \break
    c c c
  }
  \layout{ raggedright = ##t }
}
