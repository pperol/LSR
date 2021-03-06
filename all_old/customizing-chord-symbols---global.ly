%% http://lsr.di.unimi.it/LSR/Item?id=517
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/displaying-chords


% modify various chord-symbols
% chExceptionMusic is chords with markups
chExceptionMusic = {
  % make maj7 triangle smaller
  <c e g b >1-\markup { \fontsize #-2.5 { \triangle ##f } }
  % change maj11 to maj9add4
  <c e g b d' f'>1-\markup { \fontsize #-2.5 { \triangle ##f } \raise #0.6 \small "9" \raise #0.6 \teeny "add4" }
}

% Convert music to list and prepend to existing exceptions.
chExceptions = #( append
  ( sequential-music-to-chord-exceptions chExceptionMusic #t)
  ignatzekExceptions
)

% this definition in your \layout block makes the chord markup changes effective globally
\layout {
  \context { 
    \ChordNames
    chordNameExceptions = #chExceptions 
  }
}

% everything above here could be in a separate house-style file,
% and then \include that file with the score file:

\score {
  \chords {
    c1:maj7
    c:maj11
  }
}
