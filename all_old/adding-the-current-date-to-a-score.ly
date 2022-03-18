%% http://lsr.di.unimi.it/LSR/Item?id=205
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/titles#titles-adding-the-current-date-to-a-score

% first, define a variable to hold the formatted date:
date = #(strftime "%d-%m-%Y" (localtime (current-time)))

% use it in the title block:
\header {
  title = "Including the date!"
  subtitle = \date
}

\score {
  \relative c'' {
    c4 c c c
  }
}
% and use it in a \markup block:
\markup {
  \date
}
