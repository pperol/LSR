%% http://lsr.di.unimi.it/LSR/Item?id=463
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-as-lines#arpeggio

\new Staff \with {
  \consists "Span_arpeggio_engraver"
}
\relative c' {
  \set Staff.connectArpeggios = ##t
  <<
    { <e' g>4\arpeggio <d f> <d f>2 }
    \\
    { <d, f>2\arpeggio <g b>2 }
  >>
}
