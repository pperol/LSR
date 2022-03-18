%% http://lsr.di.unimi.it/LSR/Item?id=580
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/note-heads.fr.html


\relative c''' {
  \time 3/4
  \key f \major
  \set harmonicDots = ##t
  <bes f'\harmonic>2. ~
  <bes f'\harmonic>4. <a e'\harmonic>8( <gis dis'\harmonic> <g d'\harmonic>)
  <fis cis'\harmonic>2.
  <bes f'\harmonic>2.
}
