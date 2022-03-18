%% http://lsr.di.unimi.it/LSR/Item?id=776
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/chords

% Maybe I'll write a Scheme function for this, when I learn how...

slashBMusic = {
  <c e g>1-\markup \whiteout { \hspace #-2 "/B" }
}
slashB = #(sequential-music-to-chord-exceptions slashBMusic #t)

slashAMusic = {
  <c e g>1-\markup \whiteout { \hspace #-2 "/A" }
}
slashA = #(sequential-music-to-chord-exceptions slashAMusic #t)

\score { <<
  \new ChordNames \chordmode {
    c1:maj7 |
    \set chordNameExceptions = #slashB c |
    \set chordNameExceptions = #slashA c |
  }
  \new Staff \relative c'' {
    c4 c c c | c c c c | c c c c |
  }
>> }
