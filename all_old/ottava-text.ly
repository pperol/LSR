%% http://lsr.dsi.unimi.it/LSR/Item?id=380
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/pitches#pitches-ottava-text


{
  \ottava #1
  \set Staff.ottavation = #"8"
  c''1
  \ottava #0
  c'1
  \ottava #1
  \set Staff.ottavation = #"Text"
  c''1
}
