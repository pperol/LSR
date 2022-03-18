%% http://lsr.di.unimi.it/LSR/Item?id=263
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/editorial-annotations#editorial-annotations-embedding-native-postscript-in-a-_005cmarkup-block

% PostScript is a registered trademark of Adobe Systems Inc.

\relative c'' {
  a4-\markup { \postscript #"3 4 moveto 5 3 rlineto stroke" }
  -\markup { \postscript #"[ 0 1 ] 0 setdash 3 5 moveto 5 -3 rlineto stroke " }

  b4-\markup { \postscript #"3 4 moveto 0 0 1 2 8 4 20 3.5 rcurveto stroke" }
  s2
  a'1
}
