%% http://lsr.dsi.unimi.it/LSR/Item?id=163
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/writing-rhythms


\score {
 \relative c'' {
    a\breve*1/2 \autoBeamOff
    a1 a2 a4 a8 a16 a32 a64 a64
   \bar "-"
   \break
    r\longa*1/4 r\breve *1/2
    r1 r2 r4 r8 r16 r32 r64 r64
  }
  \layout {
    indent = 0
    ragged-right = ##t
    \context {
      \Staff
        \omit Clef
        \omit TimeSignature
        \omit StaffSymbol
        \omit BarLine
        \consists "Pitch_squash_engraver"
    }
    \context {
      \Score
        \remove "Bar_number_engraver"
    }
  }
}
