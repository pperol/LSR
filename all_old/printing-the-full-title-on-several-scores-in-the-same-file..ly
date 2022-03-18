%% http://lsr.di.unimi.it/LSR/Item?id=310
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/creating-titles-headers-and-footers

\header {
  composer = "The One and Only"
}

\score{
  { c' d' e' f'}
  \header{
    title = "First piece"
  }
}

\score{
  { c' d' e' f'}
  \header{
    title = "Second piece"
  }
}

\paper{
  print-all-headers=##t
  bookTitleMarkup = ##f
}
