%% http://lsr.dsi.unimi.it/LSR/Item?id=428
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/repeats#repeats-shortening-volta-brackets

\relative c'' {
  \time 3/4
  c4 c c
  \set Score.voltaSpannerDuration = #(ly:make-moment 3/4)
  \repeat volta 5 { d4 d d }
  \alternative {
    {
      e4 e e
      f4 f f
    }
    { g4 g g }
  }
}
