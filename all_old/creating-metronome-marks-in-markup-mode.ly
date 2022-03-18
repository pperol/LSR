%% http://lsr.di.unimi.it/LSR/Item?id=574
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/rhythms#rhythms-creating-metronome-marks-in-markup-mode


\relative c' {
  \tempo \markup {
    \concat {
      (
      \smaller \general-align #Y #DOWN \note #"16." #1
      " = "
      \smaller \general-align #Y #DOWN \note #"8" #1
      )
    }
  }
  c1
  c4 c' c,2
}
