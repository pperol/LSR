%% http://lsr.di.unimi.it/LSR/Item?id=671
%% see also http://www.lilypond.org/doc/v2.18/Documentation/internals/bendafter
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-as-curves#falls-and-doits


\relative c'' {
  c2-\bendAfter #+5
  c-\bendAfter #+1
  c-\bendAfter #-1
  c-\bendAfter #-5
  c-\bendAfter #3.5
  c-\bendAfter #0.5
  c-\bendAfter #-0.5
  c-\bendAfter #-3.5
}
