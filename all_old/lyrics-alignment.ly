%% http://lsr.dsi.unimi.it/LSR/Item?id=282
%% see also http://www.lilypond.org/doc/v2.18/Documentation/learning/aligning-lyrics-to-a-melody
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/vocal-music
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/techniques-specific-to-lyrics
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/vocal-music

\layout { ragged-right = ##f }
\relative c'' {
  c1
  c1
  c1
}
\addlyrics {
  \once \override LyricText.self-alignment-X = #LEFT
  "This is left-aligned"
  \once \override LyricText.self-alignment-X = #CENTER
  "This is centered"
  \once \override LyricText.self-alignment-X = #1
  "This is right-aligned"
}
