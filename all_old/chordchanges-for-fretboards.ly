%% http://lsr.di.unimi.it/LSR/Item?id=802
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/common-notation-for-fretted-strings


\include "predefined-guitar-fretboards.ly"

myChords = \chordmode {
  c1 c1 \break
  \set chordChanges = ##t
  c1 c1 \break
  c1 c1
}

<<
  \new ChordNames { \myChords }
  \new FretBoards { \myChords }
  \new Staff { \myChords }
>>
