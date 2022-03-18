%% http://lsr.dsi.unimi.it/LSR/Item?id=698

%LSR contributed by Mats Bengtsson http://lists.gnu.org/archive/html/lilypond-devel/2008-09/msg00243.html

\relative c'' {
  \set Staff.pedalSustainStyle = #'bracket
  c1\sustainOn c \sustainOff \sustainOn c\sustainOff c
  \override Staff.PianoPedalBracket.bracket-flare = #'(1 . 6)
  c1\sustainOn c \sustainOff \sustainOn c\sustainOff c
}
