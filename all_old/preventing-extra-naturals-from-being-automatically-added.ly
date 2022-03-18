%% http://lsr.di.unimi.it/LSR/Item?id=340
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/pitches#pitches-preventing-extra-naturals-from-being-automatically-added

\relative c'' {
  aeses4 aes ais a
  \set Staff.extraNatural = ##f
  aeses4 aes ais a
}
