%% http://lsr.dsi.unimi.it/LSR/Item?id=8
%% see also http://lilypond.org/doc/v2.18/Documentation/learning/visibility-and-color-of-objects
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/visibility-of-objects

\relative c'' {
  \time 2/4
  <<
    {
      \once \override Stem.transparent = ##t
      \once \override Stem.length = #8
      b8 ~ b\noBeam
      \once \override Stem.transparent = ##t
      \once \override Stem.length = #8
      g8 ~ g\noBeam
    }
    \\
    {
      b8 g g e
    }
  >>
}
