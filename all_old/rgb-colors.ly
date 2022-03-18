%% http://lsr.di.unimi.it/LSR/Item?id=420
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/inside-the-staff#coloring-objects

\relative c''{
  \override Staff.StaffSymbol.color = #(x11-color 'SlateBlue2)
  \set Staff.instrumentName = \markup {
    \with-color #(x11-color 'navy) Clarinet
  }

  %black
  \override Stem.color = #(rgb-color 0 0 0)
  gis8 a
  % white
  \override Stem.color = #(rgb-color 1 1 1)
  gis8 a
  % dark blue
  \override Stem.color = #(rgb-color 0 0 0.5)
  gis4 a
}
