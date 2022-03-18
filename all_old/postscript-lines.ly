%% http://lsr.di.unimi.it/LSR/Item?id=253
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/graphic

ViolinI = \new Staff \relative c' {
  \set Staff.instrumentName = "Violin I"
  e1 | f_\markup { \postscript #"0.6 setlinewidth 1 -0.5 moveto -2 -6 rlineto stroke" }
  g1 | a_\markup { \postscript #"1.0 setlinewidth [2 2] 0 setdash 1 1.0 moveto 2 -7 rlineto stroke" }
  d,1 | e_\markup { \postscript #"1.0 setlinewidth 1 setlinecap [1 3] 0 setdash 1 -2 moveto 0 -9 rlineto stroke" }
  f1 | g_\markup { \postscript #"1.0 setlinewidth 1 setlinecap [0 2] 0 setdash 1 -1.5 moveto 0 -10 rlineto stroke" }
  a1 | b_\markup { \postscript #"0.3 setlinewidth 1 setlinecap [0 1.5] 0 setdash 1 1 moveto 0 -11 rlineto stroke" }
  c1 | d-\markup { \postscript #"0.3 setlinewidth 1 setlinecap [0 1] 0 setdash 1 2 moveto 8 -4  -8 -7  0 -11 rcurveto stroke" }
  e1
}
ViolinII = \new Staff \relative c' {
  \set Staff.instrumentName = "Violin II"
  e1 | f | g | a
}
Viola = \new Staff \relative c' {
  \set Staff.instrumentName = "Viola"
  \clef alto
  e1 | f | g | a
  c,1 | d | e | f
  g1 | a | b | c | d
}

\score {
  <<
    \ViolinI
    \ViolinII
    \Viola
  >>
}

