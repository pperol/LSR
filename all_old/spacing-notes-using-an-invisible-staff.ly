%% http://lsr.di.unimi.it/LSR/Item?id=126
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/spacing

%LSR modified by P.P.Schneider on Feb.2014

quickmeasure =  {
  \hideNotes
  \repeat unfold 64 c''16
}

mel =  \relative c' { 
  c16 d16 e8 a4 g2 
  e8 d c2. 
  g'1 
  e4 d c2 
}

\score {
  \context PianoStaff  <<
    \new Staff <<
      \clef G
      \new Voice { \mel }
      \new Voice { \quickmeasure }
    >>
    \new Staff  { 
      \clef F 
      s1*4 
    }
  >>
  \layout {}
}

