%% http://lsr.di.unimi.it/LSR/Item?id=358
%% see also http://lsr.di.unimi.it/LSR/Item?id=359
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/templates#templates-string-quartet-template-with-separate-parts
%% see also http://lilypond.org/doc/v2.18/Documentation/learning/string-quartet-parts

global= {
  \time 4/4
  \key c \major
}

violinOne = \new Voice \relative c'' {
  \set Staff.instrumentName = #"Violin 1 "
  
  c2 d
  e1
  
  \bar "|."
}
 
violinTwo = \new Voice \relative c'' {
  \set Staff.instrumentName = #"Violin 2 "
  
  g2 f
  e1
  
  \bar "|."
}

viola = \new Voice \relative c' {
  \set Staff.instrumentName = #"Viola "  
  \clef alto
  
  e2 d
  c1
  
  \bar "|."
}

cello = \new Voice \relative c' {
  \set Staff.instrumentName = #"Cello "
  \clef bass
  
  c2 b
  a1
  
  \bar "|."
}

\score {
  \new StaffGroup <<
    \new Staff << \global \violinOne >>
    \new Staff << \global \violinTwo >>
    \new Staff << \global \viola >>
    \new Staff << \global \cello >>
  >>
  \layout { }
  \midi { }
}
