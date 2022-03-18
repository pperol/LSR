%% http://lsr.di.unimi.it/LSR/Item?id=341
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/pitches#pitches-preventing-natural-signs-from-being-printed-when-the-key-signature-changes

\relative c' {
  \key d \major
  a4 b cis d
  \key g \minor
  a4 bes c d
  \set Staff.printKeyCancellation = ##f
  \key d \major
  a4 b cis d
  \key g \minor
  a4 bes c d
}
