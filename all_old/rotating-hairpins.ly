%% http://lsr.di.unimi.it/LSR/Item?id=562
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/rotating-objects

\relative c' {
  % \override Hairpin.rotation = #'(a x y) where #'(a x y)
  % is a list that governs the angle a in degrees
  % and the x and y points to rotate around.
  % #'(45 0 0) rotates the object 45 degrees around its center
  \override Hairpin.rotation = #'(10 -1 0)
  c1*4\<
  \override Hairpin.rotation = #'(-5 0 1)
  d'1*3\!\>
  s4\!
}
