%% http://lsr.di.unimi.it/LSR/Item?id=170
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/expressive-marks#expressive-marks-caesura-_0028_0022railtracks_0022_0029-with-fermata


\relative c'' {
  c2.
  % construct the symbol
  \override BreathingSign #'text =
    \markup {
      \override #'(direction . 1)
      \override #'(baseline-skip . 1.6)
      \dir-column {
        \translate #'(0.155 . 0)
          \center-align \musicglyph #"scripts.caesura.curved"
        \center-align \musicglyph #"scripts.ufermata"
    }
  }
  \breathe c4
  % set the breathe mark back to normal
  \revert BreathingSign #'text
  c2. \breathe c4
  \bar "|."
}
