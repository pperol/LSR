%% http://lsr.dsi.unimi.it/LSR/Item?id=175
%% see also http://lilypond.org/doc/v2.18/Documentation/learning/accidentals-and-key-signatures#key-signatures

\relative c''{
  \key d \major
    a b cis d
  \key g \minor
    a bes c d
  \set Staff.printKeyCancellation = ##f
  \key d \major
    a b cis d
  \key g \minor
    a bes c d
}
