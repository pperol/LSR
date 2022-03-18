%% http://lsr.di.unimi.it/LSR/Item?id=546
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/aligning-objects
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/text#text-aligning-objects-created-with-the-_005cmark-command

\relative c' {
  c1 \mark "(Center)"
  c1
  \once \override Score.RehearsalMark.self-alignment-X = #LEFT
  \mark "(Left)"
  c4 c c c
  c4 c c c
  \once \override Score.RehearsalMark.self-alignment-X = #RIGHT
  \mark "(Right)"
  c1
}
