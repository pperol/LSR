%% http://lsr.di.unimi.it/LSR/Item?id=440
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/tweaks-and-overrides

% from Louis-Antoine Dornel: Trio sonata in F major, op. 3/2 
\relative c''' {
  \time 3/4
  \set Staff.timeSignatureFraction = #'(3 . 2)
  \override NoteHead.duration-log = #1
  a4 a a |
  cis,^\markup { \bold + } cis a |
  f'4. a8[ g f] |
  e4 e8[ f e f] |
  g2. ~ |
  g4 f8 g a4 |
  b4 e,4. fis16 g |
  fis8[ a b a g fis] |
}
