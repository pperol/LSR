%% http://lsr.di.unimi.it/LSR/Item?id=90
%% see also http://lilypond.org/doc/v2.18/Documentation/internals/bar_005fengraver


\score {
  \relative c' \context ChoirStaff <<
    \new Staff { c1 c1 c1 }
    \lyricmode <<
      \new Lyrics  { bla1 die bla }
    >>
    \new Staff { c1 c1 c1 } 
  >>

  \layout  {
    raggedright = ##t
    \context {
      \Lyrics
      \consists Bar_engraver
      %% need procedure, since lyrics doesn't have a staff_sym engraver.
      \override BarLine.bar-size-procedure = #(lambda (x) 3.0)
    }	
    \context{
      \ChoirStaff
      \remove "Span_bar_engraver"
    }
    \context {
      \Staff
      \remove "Bar_engraver"
    }
  }
}
