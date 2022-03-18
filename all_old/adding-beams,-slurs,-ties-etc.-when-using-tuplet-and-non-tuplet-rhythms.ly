%% http://lsr.di.unimi.it/LSR/Item?id=321
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/expressive-marks

{
  r16[ g16 \tuplet 3/2 { r16 e'8] }
  g16( a \tuplet 3/2 { b d e') }
  g8[( a \tuplet 3/2 { b d') e'] ~ }
  \time 2/4
  \tuplet 5/4 { e'32\( a b d' e' } a'4.\)
}
