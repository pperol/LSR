%% http://lsr.di.unimi.it/LSR/Item?id=681
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/pitches#pitches-altering-the-length-of-beamed-stems


\relative c'' {
  \override Stem.details.beamed-lengths = #'(2)
  a8[ a] a16[ a] a32[ a]
  \override Stem.details.beamed-lengths = #'(8 10 12)
  a8[ a] a16[ a] a32[ a] r8
  \override Stem.details.beamed-lengths = #'(8)
  a8[ a]
  \override Stem.details.beamed-lengths = #'(8.5)
  a8[ a]
  \revert Stem.details
  a8[ a] a16[ a] a32[ a] r16
}
