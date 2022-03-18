%% http://lsr.dsi.unimi.it/LSR/Item?id=142
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/fretted-strings


\score {
  \new TabStaff {
    \relative c'' {
      \tabFullNotation
      c4( d) d( d)
      d2( c)
    }
  }
}
