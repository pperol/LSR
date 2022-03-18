%% http://lsr.di.unimi.it/LSR/Item?id=563
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/titles


\header {
  title = "Title"
  composer = "Composer"
  arranger = "Arranger"
  tagline = \markup {
    Engraved on
    \simple #(strftime "%x at %X" (localtime (current-time)))
    with
    \with-url #"http://lilypond.org/web/" {
      LilyPond \simple #(lilypond-version) (http://lilypond.org/)
    }
  }
}

\relative c' {
  c4 d e f
}
