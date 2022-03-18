%% http://lsr.di.unimi.it/LSR/Item?id=716
%% see also http://lilypond.org/doc/v2.18/Documentation/internals/nonmusicalpapercolumn

\relative c'' {
  c1
  \override Score.NonMusicalPaperColumn.full-measure-extra-space = #0
  c1
  \override Score.NonMusicalPaperColumn.full-measure-extra-space = #-1
  c1
  \override Score.NonMusicalPaperColumn.full-measure-extra-space = #5
  c1
  \revert Score.NonMusicalPaperColumn.full-measure-extra-space
  c1
  c1
}
