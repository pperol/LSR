%% http://lsr.di.unimi.it/LSR/Item?id=640
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-as-curves


\layout {
  \context {
    \Voice
    \override BreathingSign.font-name = #"Helvetica"
    \override BreathingSign.font-size = #8
    \override BreathingSign.text = #(markup (#:raise 0.2 ","))
  }
}
\new Staff {
  \relative c'' {
    b4 b \breathe b b
  }
}
