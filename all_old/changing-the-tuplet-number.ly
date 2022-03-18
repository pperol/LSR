%% http://lsr.di.unimi.it/LSR/Item?id=405
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/writing-rhythms#tuplets


\relative c'' {
  \tuplet 3/2 { c8 c c }
  \tuplet 3/2 { c8 c c }
  \override TupletNumber.text = #tuplet-number::calc-fraction-text
  \tuplet 3/2 { c8 c c }
  \override TupletNumber.stencil = ##f
  \tuplet 3/2 { c8 c c }
}
