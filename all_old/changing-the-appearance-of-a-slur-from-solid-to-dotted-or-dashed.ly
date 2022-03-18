%% http://lsr.di.unimi.it/LSR/Item?id=133
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/editorial-annotations#editorial-annotations-changing-the-appearance-of-a-slur-from-solid-to-dotted-or-dashed


\relative c' {
  c4( d e c)
  \slurDotted
  c4( d e c)
  \slurSolid
  c4( d e c)
  \slurDashed
  c4( d e c)
  \slurSolid
  c4( d e c)
}
