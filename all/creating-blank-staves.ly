\version "2.22.2"
%% http://lsr.di.unimi.it/LSR/Item?id=5

\score {
  {
    \repeat unfold 12 { s1 \break }
  }
  \layout {
    indent = 0
    \context {
      \Staff
      \omit TimeSignature
      \omit Clef
      \omit BarLine
    }
    \context {
      \Score
      \omit BarNumber
    }
  }
}

% uncomment these lines for "letter" size
%{
\paper {
  #(set-paper-size "letter")
  ragged-last-bottom = ##f
  line-width = 7.5\in
  left-margin = 0.5\in
  bottom-margin = 0.25\in
  top-margin = 0.25\in
}
%}

% uncomment these lines for "A4" size
%{
\paper {
  #(set-paper-size "a4")
  ragged-last-bottom = ##f
  line-width = 180
  left-margin = 15
  bottom-margin = 10
  top-margin = 10
}
%}