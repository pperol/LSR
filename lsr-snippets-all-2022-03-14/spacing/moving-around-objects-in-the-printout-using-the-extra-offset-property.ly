\header {
  texidoc = "
The @code{extra-offset} property, which has a pair of numbers as value,
moves around objects in the printout.  The first number controls
left-right movement; a positive number will move the object to the
right.  The second number controls up-down movement; a positive number
will move it higher.  The units of these offsets are staff-spaces.  The
@code{extra-offset} property is a low-level feature: the formatting
engine is completely oblivious to these offsets.

"
  doctitle = "Moving around objects in the printout using the extra-offset property"
}
%% http://lsr.di.unimi.it/LSR/Item?id=7
%% see also http://lilypond.org/doc/v2.18/Documentation/learning/moving-objects

\relative c' {
  \stemUp
  f-5
  \once \override Fingering.extra-offset = #'(-0.3 . -1.8) 
  f-5

}


