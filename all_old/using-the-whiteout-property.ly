%% http://lsr.di.unimi.it/LSR/Item?id=831
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/editorial-annotations#editorial-annotations-using-the-whiteout-property
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/graphic

{
  \override Score.StaffSymbol.layer = #4
  \override Staff.TimeSignature.layer = #3
  b'2 b'~
  \once \override Staff.TimeSignature.whiteout = ##t
  \time 3/4
  b' r4
}
