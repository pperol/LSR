%% http://lsr.dsi.unimi.it/LSR/Item?id=147
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/titles#titles-outputting-the-version-number

\score {
  \new Lyrics {
    \override Score.RehearsalMark.self-alignment-X = #LEFT
    \mark #(string-append "Processed with LilyPond version " (lilypond-version))
    s2
  }
}
