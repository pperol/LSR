\header {
  texidoc = "
You can move @code{Bar_engraver} and @code{Span_bar_engraver} to  a
different engraving context, if you want, for example, bar lines  on
lyrics. 

"
  doctitle = "Displaying bar lines on lyrics"
}
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
      \consists "Bar_engraver"
      \consists "Separating_line_group_engraver"
      \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4.2
      \override LyricText.Y-offset = #-0.7
      \override BarLine.bar-extent = #'(-2 . 2)
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
