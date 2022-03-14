\version "2.18.0"

\header {
  texidoc = "
To position two fermata signs on the last bar line (a typical setup in
XVIII century music) add the @code{Mark_engraver} to the lower staff
using @code{\\with}. 

"
  doctitle = "Positioning two opposite \\fermata signs over the last bar line"
}
%% http://lsr.di.unimi.it/LSR/Item?id=10

\paper {
  indent = 0\mm
}

\score {
  \new GrandStaff <<
    \context Staff = "one" {
      c'1 \bar "|."
    }
    \context Staff = "two" \with { \consists "Mark_engraver" } {
      c'1
      \override Score.RehearsalMark.break-visibility = #begin-of-line-invisible
      \mark \markup { \musicglyph #"scripts.ufermata" }
      
      %% The RehearsalMark in Staff is overriden, while not touching the one
      %% from Score.
      \override Staff.RehearsalMark.direction = #DOWN
      \override Staff.RehearsalMark.rotation = #'(180 0 0)
      
      %%Instead of rotating, as shown above, other text is possible:
      % \override Staff.RehearsalMark.stencil =
      %   #(lambda (grob) 
      %     (grob-interpret-markup grob 
      %       #{ \markup \vcenter { [ \musicglyph #"scripts.dfermata" ] } #}))
    }
  >>
}
