%% http://lsr.di.unimi.it/LSR/Item?id=875
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/pitches#pitches-adding-an-ottava-marking-to-a-single-voice

{ 
  \clef bass
  << { <g d'>1~ q2 <c' e'> }
  \\ 
    {
      r2.
      \set Staff.ottavation = #"8vb"
      \once \override Staff.OttavaBracket.direction = #DOWN
      \set Voice.middleCPosition = #(+ 6 7)
      <b,,, b,,>4 ~ |
      q2
      \unset Staff.ottavation
      \unset Voice.middleCPosition
      <c e>2
    } 
  >> 
}
