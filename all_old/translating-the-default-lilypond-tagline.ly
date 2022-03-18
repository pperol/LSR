%% http://lsr.di.unimi.it/LSR/Item?id=366
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/creating-titles-headers-and-footers


%LSR thanks to John Mandereau for this snippet

\header {
  %% taken from titling-init.ly
  tagline = \markup {
    \with-url
    #"http://lilypond.org/web/"
    \line {
      %% feel free to translate this line to your own language
      "This score has been wonderfully engraved thanks to the awesome LilyPond"
      $(lilypond-version)
      \char ##x2014
      "http://lilypond.org"
    }
  }
}

\relative c' {
  c4 d e f
}
