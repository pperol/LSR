%% http://lsr.dsi.unimi.it/LSR/Item?id=457
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/multiple-voices.fr.html

ignore = \override NoteColumn.ignore-collision = ##t

\relative c' {
  <<
    \ignore
    { \stemDown f2 g }
    \\
    { c2 c, }
  >>
}
