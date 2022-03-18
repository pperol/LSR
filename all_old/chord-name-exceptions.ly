%% http://lsr.di.unimi.it/LSR/Item?id=459
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/chords#chords-chord-name-exceptions


% modify maj9 and 6(add9)
% Exception music is chords with markups
chExceptionMusic = {
  <c e g b d'>1-\markup { \super "maj9" }
  <c e g a d'>1-\markup { \super "6(add9)" }
}

% Convert music to list and prepend to existing exceptions.
chExceptions = #( append
  ( sequential-music-to-chord-exceptions chExceptionMusic #t)
  ignatzekExceptions)

theMusic = \chordmode {
  g1:maj9 g1:6.9
  \set chordNameExceptions = #chExceptions
  g1:maj9 g1:6.9
}

\layout {
  ragged-right = ##t 
}

<< \context ChordNames \theMusic
   \context Voice \theMusic
>>  
