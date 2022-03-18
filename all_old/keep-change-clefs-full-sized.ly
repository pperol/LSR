%% http://lsr.dsi.unimi.it/LSR/Item?id=673
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/pitches#pitches-keep-change-clefs-full-sized

\relative c' {
  \clef "treble"
  c1
  \clef "bass"
  c1
  \clef "treble"
  c1
  \override Staff.Clef.full-size-change = ##t
  \clef "bass"
  c1
  \clef "treble"
  c1
  \revert Staff.Clef.full-size-change
  \clef "bass"
  c1
  \clef "treble"
  c1
}
