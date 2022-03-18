%% http://lsr.di.unimi.it/LSR/Item?id=560
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/rhythms#rhythms-removing-bar-numbers-from-a-score

%LSR modified by P.P.Schneider on Feb. 2014.

\layout {
  \context {
    \Score
    \omit BarNumber
    % or:
    %\remove "Bar_number_engraver"
  }
}

\relative c'' {
  c4 c c c \break
  c4 c c c
}
