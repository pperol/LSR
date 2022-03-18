%% http://lsr.di.unimi.it/LSR/Item?id=423
%% see also http://lilypond.org/doc/v2.18/Documentation/internals/balloon_002dinterface
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/outside-the-staff

\new Voice \with { \consists "Balloon_engraver" }
  \relative c''{
   \balloonGrobText #'Stem #'(3 . 4) \markup { "I'm a Stem" }
   a4
   <c, g'-\balloonText #'(-2 . -2) \markup { "I'm a note head" } c>2.
}
