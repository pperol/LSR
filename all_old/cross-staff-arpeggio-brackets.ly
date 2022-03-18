%% http://lsr.di.unimi.it/LSR/Item?id=470
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-as-lines#arpeggio


csBracket = \override PianoStaff.Arpeggio.stencil = #ly:arpeggio::brew-chord-bracket


\score{
  \new PianoStaff \with { connectArpeggios = ##t } <<
  \new Staff { 
    \arpeggioBracket c''1\arpeggio
    \csBracket c'' \arpeggio 
  }
  \new Staff { 
    \arpeggioBracket c'1 \arpeggio
    \csBracket c'  \arpeggio 
  }
 >>
}
