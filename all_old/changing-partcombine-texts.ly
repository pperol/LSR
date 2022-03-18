%% http://lsr.di.unimi.it/LSR/Item?id=492
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/simultaneous-notes#simultaneous-notes-changing-partcombine-texts

\new Staff <<
  \set Staff.soloText = #"girl"
  \set Staff.soloIIText = #"boy"
  \set Staff.aDueText = #"together"
  \partcombine
    \relative c'' {
      g4 g r r
      a2 g
    }
    \relative c'' {
      r4 r a( b)
      a2 g
    }
>>
