%% http://lsr.dsi.unimi.it/LSR/Item?id=88
%% see also http://www.lilypond.org/doc/v2.18/Documentation/internals/score

\score {
  \relative c''{
    \set Score.barAlways = ##t
    \set Score.defaultBarType = ":..:"
    c4 c4 c4 c4 
  }
}
