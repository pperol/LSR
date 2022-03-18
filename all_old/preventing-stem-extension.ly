%% http://lsr.di.unimi.it/LSR/Item?id=141
%% see also http://lilypond.org/doc/v2.18/Documentation/internals/stem_002dinterface

\score { 
  \context Voice \relative c {
    \context Staff <<
      \new Voice { 
        f2 f8 g a b 
        \override Stem.no-stem-extend = ##t
        f2 f8 g a b
      }
      \new Voice { 
        c''2 c8 b a g
        \override Stem.no-stem-extend = ##t
        c2 c8 b a g
      }
    >>
  }
}
