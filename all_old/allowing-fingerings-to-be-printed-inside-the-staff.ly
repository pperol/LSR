%% http://lsr.di.unimi.it/LSR/Item?id=417
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/inside-the-staff#fingering-instructions
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/fretted-strings#fretted-strings-allowing-fingerings-to-be-printed-inside-the-staff


\relative c' {
  <c-1 e-2 g-3 b-5>2
  \override Fingering.staff-padding = #'()
  <c-1 e-2 g-3 b-5>4 <g'-0>
}
