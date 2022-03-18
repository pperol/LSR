%% http://lsr.di.unimi.it/LSR/Item?id=555
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/text#text-printing-text-from-right-to-left


{
  b1^\markup {
        \line { i n g i r u m i m u s n o c t e }
      }
  f'_\markup {
        \override #'(text-direction . -1)
        \line { i n g i r u m i m u s n o c t e }
    }
}
