%% http://lsr.di.unimi.it/LSR/Item?id=303
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-as-lines#glissando


\relative c {
  \clef bass
  <<
    {
      % new voice ( = \voiceOne), hidden
      \hideNotes
      % attach glissando to note heads
      e2\glissando g
    }
    \\
    { 
      % original voice with chords rearranged so that
      % glissando is attached to a & c
      <e a,>2\glissando <g c,>
    }
  >>
}
